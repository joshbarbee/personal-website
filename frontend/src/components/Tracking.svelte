<script lang="ts">
    import { onMount } from "svelte";
    import { currentFingerprint, fingerprintEnabled } from "../lib/store";
    import Fingerprint from "../lib/fingerprint";

    let actionData : object[] = [];
    
    onMount(async () => {
        if (!$currentFingerprint) {
            currentFingerprint.set(new Fingerprint());
        }
    });

    const disableTracking = async () => {
        if ($currentFingerprint) {
            await $currentFingerprint.deleteTrackedActions();
            $currentFingerprint = null;
            fingerprintEnabled.set(false);
        }
    };

    const getInfo = async () => {
        if ($currentFingerprint) {
            actionData = await $currentFingerprint.getTrackedActions();
            console.log(actionData);
        }
    };

    const newFingerprint = async () => {
        currentFingerprint.set(new Fingerprint());
        fingerprintEnabled.set(true);
    };
</script>


<div>
    <h1>
        This website tracks your activity via browser fingerprinting. Your browser fingerprint is: {$currentFingerprint?.getFingerprintHash()}
    </h1>
    <p>
        To get all tracked information for your fingerprint, click the button below. Limited to last 100 results.
    </p>
    <div>
        {#if actionData.length > 0}
            <table>
                <thead>
                    <tr>
                        <th>Type</th>
                        <th>Tag</th>
                        <th>Text</th>
                        <th>Timestamp</th>
                    </tr>
                </thead>
                <tbody>
                    {#each actionData as action}
                        <tr>
                            <td>{action.type}</td>
                            <td>{action.data.tag}</td>
                            <td>{action.data.text}</td>
                            <td>{action.timestamp}</td>
                        </tr>
                    {/each}
                </tbody>
            </table>
        {/if}
    </div>
    {#if $fingerprintEnabled && $currentFingerprint}
        <button id='getinfo' on:click={getInfo}> Get Tracked Info </button>
    {/if}
    {#if $fingerprintEnabled && $currentFingerprint}
        <p>
            To disable tracking and delete existing information for your fingerprint, click the button below.
        </p>
        <button id='disable' on:click={async () => disableTracking()}> Disable Tracking </button>
    {:else}
        <p> Tracking is already disabled. You cannot query fingerprint information.</p>
        <p> To reenable tracking, click the following button:</p>
        <button id='disable' on:click={async () => newFingerprint()}> Enable Tracking </button>
    {/if}
</div>

<style>
    div {
        padding: var(--spacing-s);
        text-align: left;
        margin: var(--spacing-l) auto;
        width: 50%;
    }

    h1 {
        font-size: var(--font-l);
    }

    p {
        font-size: var(--font-s);
    }

    #disable {
        background-color: red;
    }

    #getinfo {
        background-color: blue;
        margin-right: var(--spacing-s);
    }

    button {
        background-color: var(--background-secondary-color);
        border: 2px solid var(--primary-color);
        color: var(--primary-color);
        padding: var(--spacing-s);
    }

    table {
        width: 100%;
        border-collapse: collapse;
    }

    th, td {
        border: 1px solid black;
        padding: var(--spacing-s);
    }

    th {
        background-color: var(--background-quaternary-color);
    }

    tr:nth-child(even) {
        background-color: var(--background-tertiary-color);
    }

    tr:nth-child(odd) {
        background-color: var(--background-quaternary-color);
    }

    @media (max-width: 1440px) {
        div {
            width: 60%;
        }
    }

    @media (max-width: 1024px) {
        div {
            width: 80%;
        }
    }

    @media (max-width: 768px) {
        div {
            width: 100%;
        }
    }
</style>