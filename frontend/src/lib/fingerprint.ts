
// see https://github.com/bryc/code/blob/master/jshash/experimental/cyrb53.js
const cyrb53 = (str : string, seed = 0) => {
    let h1 = 0xdeadbeef ^ seed, h2 = 0x41c6ce57 ^ seed;
    for(let i = 0, ch; i < str.length; i++) {
        ch = str.charCodeAt(i);
        h1 = Math.imul(h1 ^ ch, 2654435761);
        h2 = Math.imul(h2 ^ ch, 1597334677);
    }
    h1  = Math.imul(h1 ^ (h1 >>> 16), 2246822507);
    h1 ^= Math.imul(h2 ^ (h2 >>> 13), 3266489909);
    h2  = Math.imul(h2 ^ (h2 >>> 16), 2246822507);
    h2 ^= Math.imul(h1 ^ (h1 >>> 13), 3266489909);
  
    return 4294967296 * (2097151 & h2) + (h1 >>> 0);
};

class TrackerAction {
    type: string;
    data: Object;
    timestamp: Number;

    constructor(type : string, data: Object) {
        this.type = type;
        this.data = data;
        this.timestamp = Date.now();
    }

    toObject = () => {
        return {
            type: this.type,
            data: this.data,
            timestamp: this.timestamp,
        };
    }
}

class Fingerprint {
    userAgent: string = "";
    buildId: string = "";
    language: string = "";
    oscpu: string = "";
    platform: string = "";
    doNotTrack: Boolean = false;
    cookieEnabled: Boolean = false;
    mimeTypes: string[] = [];
    plugins: string[] = [];
    hardwareConcurrency: Number = 0;
    supportedAudioFormats: string[] = [];

    trackerActions: TrackerAction[] = [];

    constructor() {
        this.getFingerprint();
        this.runTracker();
    }

    runTracker = async () => {
        document.addEventListener("click", (e) => {
            const target = e.target as HTMLElement;
            let action : TrackerAction;

            if (target.tagName === "A") {
                action = new TrackerAction("click", {
                    tag: "a",
                    href: target.getAttribute("href"),
                    text: target.innerText,
                });

                this.trackerActions.push(action);
            }

            if (target.tagName === "BUTTON") {
                action = new TrackerAction("click", {
                    tag: "button",
                    text: target.innerText,
                });

                this.trackerActions.push(action);
            }
        });

        document.addEventListener("submit", (e) => {
            const target = e.target as HTMLElement;
            let action : TrackerAction;

            if (target.tagName === "FORM") {
                action = new TrackerAction("submit", {
                    tag: "form",
                    action: target.getAttribute("action"),
                    method: target.getAttribute("method"),
                    data: new FormData(target as HTMLFormElement),
                });

                this.trackerActions.push(action);
            }

            if (target.tagName === "BUTTON") {
                action = new TrackerAction("click", {
                    tag: "button",
                    text: target.innerText,
                });

                this.trackerActions.push(action);
            }
        });

        document.addEventListener("scroll", (e) => {
            const action = new TrackerAction("scroll", {
                scrollY: window.scrollY,
            });

            this.trackerActions.push(action);
        });

        setInterval(() => {
            this.runTrackerUpdate();
        }, 1000 * 60 * 5);
    }

    runTrackerUpdate = async () => {
        if (this.trackerActions.length == 0) {
            return;
        }
        
        const actions = this.trackerActions.map((action) => action.toObject());

        fetch("/api/track", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify({
                fingerprint: this.getFingerprintHash(),
                actions: actions,
            }),
        });

        this.trackerActions = [];
    }

    getNavigatorProps = () => {
        this.userAgent = navigator.userAgent;
        this.language = navigator.language;
        this.buildId = (navigator as any).buildID || "";
        this.oscpu = (navigator as any).oscpu || "";
        this.platform = navigator.platform;
        this.doNotTrack = navigator.doNotTrack === "1" || navigator.doNotTrack === "yes";
        this.cookieEnabled = navigator.cookieEnabled;
        this.mimeTypes = Array.from(navigator.mimeTypes).map((mimeType) => mimeType.type);
        this.plugins = Array.from(navigator.plugins).map((plugin) => plugin.name);
        this.hardwareConcurrency = navigator.hardwareConcurrency;
    }

    getSupportedAudioFormats = () => {
        const audio = document.createElement("audio");
        const formats = [
            "audio/mpeg", 
            "audio/ogg", 
            "audio/wav",
            "audio/mp4",
            "audio/aac",
            "audio/x-msvideo",
            "audio/midi",
            "audio/x-midi",
            "audio/webm",
            "audio/3gpp",
            "audio/3gpp2",
        ];
        this.supportedAudioFormats = formats.filter((format) => {
            return audio.canPlayType(format) === "probably" || audio.canPlayType(format) === "maybe";
        });
    }

    getFingerprint = async () => {
        this.getNavigatorProps();
        this.getSupportedAudioFormats();
    }

    getFingerprintHash = () : Number => {
        const fingerprint = [
            this.userAgent,
            this.buildId,
            this.language,
            this.oscpu,
            this.platform,
            this.doNotTrack,
            this.cookieEnabled,
            this.mimeTypes.join(","),
            this.plugins.join(","),
            this.hardwareConcurrency,
            this.supportedAudioFormats.join(","),
        ].join(",");
        return cyrb53(fingerprint);
    }

    toObject = () : Object => {
        return {
            userAgent: this.userAgent,
            buildId: this.buildId,
            language: this.language,
            oscpu: this.oscpu,
            platform: this.platform,
            doNotTrack: this.doNotTrack,
            cookieEnabled: this.cookieEnabled,
            mimeTypes: this.mimeTypes,
            plugins: this.plugins,
            hardwareConcurrency: this.hardwareConcurrency,
            supportedAudioFormats: this.supportedAudioFormats,
        };
    }

    deleteTrackedActions = async () => {
        this.trackerActions = [];

        await fetch("/api/donottrack", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify({
                fingerprint: this.getFingerprintHash(),
            }),
        });
    }

    getTrackedActions = async () => {
        let data = await fetch("/api/trackedactions", {
            method: "POST",
            headers: {
                "Content-Type": "application/json",
            },
            body: JSON.stringify({
                fingerprint: this.getFingerprintHash(),
            }),
        });

        if (!data.ok) {
            return [];
        }

        let actions = await data.json();

        let res = [];

        for (let log of actions) {
            for (let action of log.Actions) {
                res.push(action);
            }
        }

        return res;
    }
}

export default Fingerprint;