bench:
	moon clean
	moon build
	deno bench -A ./deno/run.ts
