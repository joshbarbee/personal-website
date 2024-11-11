<script lang="ts">
    const birthDate = new Date(2002, 5, 15);
    const today = new Date();
    const ageDifMs = today.getTime() - birthDate.getTime();
    const ageDate = new Date(ageDifMs);
    const age = Math.abs(ageDate.getUTCFullYear() - 1970);
</script>

<div>
    <h1>About Me</h1>
    <p>My name is Josh Barbee. I am a {age} year old developer from Cincinnati, Ohio with a focus in Cybersecurity and Networking.</p>
    <br>
    <h3>Education</h3>
    <p>
        I graduated with my Bachelors of Engineering in Computer Science and Engineering at The Ohio State University in 2023, Summa Cum Laude. 
        I graduated with my Masters of Science in Computer Science and Engineering at The Ohio State University in 2024.
        While at Ohio State, I researched under <a href="https://zhiqlin.github.io/">Dr. Zhiqiang Lin</a> in the OSU Security Lab, focusing on blockchain security as it pertains to smart contracts.
    </p>
    <br>
    <h3>Professional Experience</h3>
    <p>
        I am currently an Associate Software Engineer at <a href="https://capitalone.com">Capital One</a> in McLean, Virginia. I am a member of the Web Application Firewall team, working to
        support and maintain the WAF infrastructure that protects Capital One's web applications. I previously interned at Capital One in the summer of 2023 in the Technology Internship Program,
        where I was a member of the Capital One Lab, designing innovative applications leveraging large language models and in 2022, where I supported internal teams with migrating new 
        business-to-business clients to Capital One.
    </p>
    <br>
    <h3>About This Site</h3>
    <p>
        The source code for the site can be found at <a href="https://github.com/joshbarbee/personal-website>"> this GitHub repository</a>. The site is a SPA built with Svelte and Vite, hosted on
        S3 and CloudFront. This site is the second iteration of an attempt to create a website to monitor how often this domain is visited. Upon visiting this site, your device is uniquely
        fingerprinted and your visiting habits are tracked. Once a day, information regarding site visitors is emailed to me. The initial version of the site was a Lambda which would return a
        basic HTML page, and proxy request metadata to a backend Lambda, however, that version suffered from poor SEO and thus was unable to be indexed by web crawlers.
    </p>
</div>

<style>
    div {
        text-align: center;
        margin: 0 auto;
        padding: var(--spacing-xl);
        width: 50%;
    }

    h1 {
        margin: 0;
        padding-bottom: var(--spacing-xl);
    }

    p {
        margin: 0;
        padding-bottom: var(--spacing-xl);
        text-align: left;
    }

    h3 {
        margin: 0;
        padding-bottom: var(--spacing-xl);
    }

    @media
    only screen and (max-width: 760px) {
        div {
            width: 70%;
        }
    }

    @media
    only screen and (max-width: 500px) {
        div {
            width: 100%;
        }
    }
</style>