const buf = await fetch(new URL("../target/wasm/release/build/main/main.wasm", import.meta.url)).then(response => response.arrayBuffer());
console.log(buf.byteLength);
const [log, flush] = (() => {
  let buffer: number[] = [];
  function flush() {
    if (buffer.length > 0) {
      console.log(new TextDecoder().decode(new Uint8Array(buffer).valueOf()));
      buffer = [];
    }
  }
  function log(ch: number) {
    if (ch == '\n'.charCodeAt(0)) { flush(); }
    else if (ch == '\r'.charCodeAt(0)) { /* noop */ }
    else { buffer.push(ch); }
  }
  return [log, flush]
})();
const wasm = await WebAssembly.instantiate(buf, {
  spectest: {
    print_char: log
  },
  math: {
    random: Math.random
  }
});

const sort = wasm.instance.exports["username/hello/main::sort"] as (arr: number[]) => void;
const gen_random = wasm.instance.exports["username/hello/main::gen_random"] as (n: number) => number[];
const gen_sorted = wasm.instance.exports["username/hello/main::gen_sorted"] as (n: number) => number[];
const gen_reversed = wasm.instance.exports["username/hello/main::gen_reversed"] as (n: number) => number[];
const gen_same = wasm.instance.exports["username/hello/main::gen_same"] as (n: number) => number[];

Deno.bench("sort", (t) => {
  const num = gen_random(100_000);
  t.start();
  sort(num);
  t.end();
})

Deno.bench("sort sorted", (t) => {
  const num = gen_sorted(100_000);
  t.start();
  sort(num);
  t.end();
})

Deno.bench("sort reversed", (t) => {
  const num = gen_reversed(100_000);
  t.start();
  sort(num);
  t.end();
})

Deno.bench("sort same", (t) => {
  const num = gen_same(100_000);
  t.start();
  sort(num);
  t.end();
})
