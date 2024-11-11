<script lang="ts">
    import Title from "./components/Title.svelte";
    import Nav from "./components/Nav.svelte";
    import About from "./components/About.svelte";
    import Contact from "./components/Contact.svelte";

    import { selectedNavItem } from "./lib/store";
</script>

<svelte:head>
    <title>josh barbee | {$selectedNavItem}</title>
</svelte:head>

<main>
    {#if $selectedNavItem === ""}
        <Title />
    {:else if $selectedNavItem === "about"}
        <About />
    {:else if $selectedNavItem === "contact"}
        <Contact />
    {/if}
    <Nav />
</main>