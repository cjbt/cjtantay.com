<script>
	/** @type {import('./$types').PageData} */
	export let data;
	console.log(data);
</script>

{#if !data.name}
	<p>loading...</p>
{:else}
	<p>{data.name}</p>
{/if}
