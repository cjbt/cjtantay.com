<script>
	import 'normalize.css';
	import Header from './Header.svelte';
</script>

<div class="app">
	<Header />
	<main>
		<slot />
	</main>
</div>

<style>
	main {
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
		width: 100%;
		max-width: 100vw;
		height: 100%;
		max-height: 100vh;
	}
</style>
