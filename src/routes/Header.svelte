<script>
	// let;
</script>

<svelte:head>
	<title>cj's site</title>
	<meta name="description" content="cj tantay's personal site" />
</svelte:head>

<div class="header">
	<h1>C. J. Tantay</h1>
	<div>
		<p>
			Software Engineer - @ <a href="https://www.hotelengine.com/">hotel engine</a>, prev
			<a href="https://www.latimes.com/">los angeles times</a>
		</p>
	</div>

	<div>
		<p>
			my socials - <a href="https://www.hotelengine.com/">github</a>,
			<a href="https://www.linkedin.com/in/cjtantay/">linkedin</a>,
			<a href="https://twitter.com/cjtantay">twitter</a>
		</p>
	</div>
	<div>
		<nav>
			<p>my stack - <a href="/frontend">frontend</a>, <a href="/backend">backend</a></p>
			<div class="blog-container"><p><a href="/blog">my blog</a></p></div>
		</nav>
	</div>
</div>

<style>
	.header {
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
		width: 100%;
		max-width: 100vw;
		height: 100%;
		max-height: 100vh;
	}

	.blog-container {
		display: flex;
		flex-direction: column;
		align-items: center;
		justify-content: center;
	}
</style>
