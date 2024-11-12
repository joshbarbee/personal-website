<script lang="ts">
    import Title from "./components/Title.svelte";
    import Nav from "./components/Nav.svelte";
    import About from "./components/About.svelte";
    import Contact from "./components/Contact.svelte";
    import Tracking from "./components/Tracking.svelte";
    import TrackingWarning from "./components/TrackingWarning.svelte";
    import Projects from "./components/Projects.svelte";

    import { selectedNavItem, showTracking, currentFingerprint, fingerprintEnabled } from "./lib/store";
    $ : $selectedNavItem = $selectedNavItem;
</script>

<svelte:head>
    <title>josh barbee | {$selectedNavItem}</title>
</svelte:head>

<svelte:window on:visibilitychange={async () => $currentFingerprint?.runTrackerUpdate()}/>

<main>
    <content>
        {#if $selectedNavItem === ""}
        <Title />
        {:else if $selectedNavItem === "about"}
            <About />
        {:else if $selectedNavItem === "contact"}
            <Contact />
        {:else if $selectedNavItem === "tracking"}
            <Tracking />
        {:else if $selectedNavItem === "projects"}
            <Projects />
        {:else}
            <p>Page not found</p>
        {/if}
    </content>
    <div id='footer'>
        {#if $showTracking && $selectedNavItem !== "tracking" && $fingerprintEnabled}
            <TrackingWarning />
        {/if}
        <Nav />
    </div>
</main>

<style>
    #footer {
        position: fixed;
        bottom: 0;
        width: 100%;
    }
</style>