<script lang="ts">
    import Fa from 'svelte-fa';

    import { faLinkedin, faGithub } from '@fortawesome/free-brands-svg-icons';
    import { faEnvelope } from '@fortawesome/free-solid-svg-icons';
</script>

<div class="contact-container">
    <h1>Contact Me</h1>
    <a href="https://www.linkedin.com/in/josh-barbee" target="_blank"> 
        <Fa icon={faLinkedin} />
        LinkedIn
    </a>
    <a href="https://github.com/joshbarbee" target="_blank">
        <Fa icon={faGithub} />
        GitHub
    </a>
    <a href="mailto:joshbarbee1@gmail.com">
        <Fa icon={faEnvelope} />
        Email
    </a>
</div>

<style>
    div {
        display: flex;
        flex-direction: column;
        align-items: center;
        padding: 2rem;
    }

    a {
        margin: 0.5rem 0;
        text-decoration: none;
        font-size: var(--font-m);
    }
</style>