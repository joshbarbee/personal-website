<script lang="ts">
    const projects = [
        {
            title: "Project 1",
            description: "This is a description of project 1",
            link: "https://www.google.com"
        },
        {
            title: "Project 2",
            description: "This is a description of project 2",
            link: "https://www.google.com"
        },
        {
            title: "Project 3",
            description: "This is a description of project 3",
            link: "https://www.google.com"
        }
    ]
</script>
<div>
    <div>
        <h1>Projects</h1>
        <p>A full list of my projects can be found <a href="https://github.com/joshbarbee">at my Github.</a></p>
    </div>
    {#each projects as project}
        <div>
            <h2>{project.title}</h2>
            <p>{project.description}</p>
            <a href={project.link
            }>Link</a>
        </div>
    {/each}
</div>

<style>
    div {
        text-align: left;
        margin: 0 auto;
        width: 80%;
        padding: var(--spacing-md);
    }

    h1, h2{
        text-align: center;
    }
    

    @media (max-width: 760px) {
        div {
            width: 100%;
        }
    }
</style>