<script lang="ts">
    import { selectedNavItem } from "../lib/store";

    const navItems = [
        { id: "about", text: "About Me" },
        { id: "blog", text: "Blog" },
        { id: "projects", text: "Projects" },
        { id: "contact", text: "Contact" },
        { id: "tracking", text: "Tracking" }
    ];

    function handleNavClick(id : string) {
        selectedNavItem.set(id);
    }

    $: selectedNavItem;
</script>

<div class="navbar">
    {#each navItems as { id, text }}
        <a
            href={`#${id}`}
            on:click={() => handleNavClick(id)}
            class:active={$selectedNavItem === id}
        >
            {text}
        </a>
    {/each}
</div>

<style>
    div {
        background-color: var(--background-secondary-color);
        color: var(--primary-color);
        text-align: center;
        padding: var(--spacing-m);
    }

    a {
        color: white;
        padding: var(--spacing-m) var(--spacing-m);
        text-decoration: none;
    }

    a:hover {
        background-color: var(--background-tertiary-color);
        text-decoration: underline;
    }

    .active {
        background-color: var(--background-quaternary-color);
    }
</style>