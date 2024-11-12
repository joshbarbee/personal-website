<script lang="ts">
    import { showTracking } from "../lib/store";
    import { onMount } from "svelte";
    import { currentFingerprint, fingerprintEnabled } from "../lib/store";
    import Fingerprint from "../lib/fingerprint";
    
    onMount(async () => {
        if (!$currentFingerprint && fingerprintEnabled) {
            currentFingerprint.set(new Fingerprint());
        }
    });

    const disableTracking = async () => {
        if ($currentFingerprint) {
            await $currentFingerprint.deleteTrackedActions();
            $currentFingerprint = null;
            fingerprintEnabled.set(false);
        }

        showTracking.set(false);
    };

</script>

<div>
    <p> This website tracks your activity via browser fingerprinting.</p>
    <p> Your browser fingerprint is: {$currentFingerprint?.getFingerprintHash()} </p>
    <button id='disable' on:click={async () => disableTracking()}> Disable Tracking </button>
    <button id='close' on:click={async () => showTracking.set(false)}> Close </button>
</div>

<style>
    div {
        background-color: var(--background-quaternary-color);
        padding: var(--spacing-s);
        text-align: left;
        width: 30%;
        margin: var(--spacing-l) auto;
        box-shadow: 0 0 10px 0 rgba(184, 184, 184, 0.1);
        border: 1px solid rgba(184, 184, 184, 0.1);
        border-radius: 4px
    }

    p {
        font-size: var(--font-s);
    }

    #close {
        background-color: red;
        margin-left: var(--spacing-s);
    }

    #disable {
        background-color: blue;
        margin-right: var(--spacing-s);
    }

    button {
        background-color: var(--background-secondary-color);
        border: 2px solid var(--primary-color);
        color: var(--primary-color);
        padding: var(--spacing-s);
        cursor: pointer;
        border-radius: 4px;
    }

    button:hover {
        background-color: var(--background-tertiary-color);
    }

    @media (max-width: 1024px) {
        div {
            width: 50%;
        }
    }

    @media (max-width: 768px) {
        div {
            width: 80%;
        }
    }

    @media (max-width: 480px) {
        div {
            width: 100%;
        }
    }
</style>