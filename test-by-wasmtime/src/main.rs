use wasmtime::*;

#[derive(Clone)]
struct CustomType {}

fn main() -> wasmtime::Result<()> {
    println!("Hello, world!");
    let engine = Engine::default();

    let module = Module::new(
        &engine,
        include_bytes!("../../target/wasm/release/build/main/main.wasm"),
    )?;

    // Host functionality can be arbitrary Rust functions and is provided
    // to guests through a `Linker`.
    let mut linker = Linker::new(&engine);
    linker.func_wrap("math", "random", |_caller: Caller<'_, u32>| {
        rand::random::<f64>()
    })?;

    // All wasm objects operate within the context of a "store". Each
    // `Store` has a type parameter to store host-specific data, which in
    // this case we're using `4` for.
    let mut store: Store<u32> = Store::new(&engine, 4);

    // Instantiation of a module requires specifying its imports and then
    // afterwards we can fetch exports by name, as well as asserting the
    // type signature of the function with `get_typed_func`.
    let instance = linker.instantiate(&mut store, &module)?;
    let gen = instance
        .get_func(&mut store, "username/hello/main::gen_random")
        .unwrap();
    let sort = instance
        .get_func(&mut store, "username/hello/main::sort")
        .unwrap();
    let mut result = [Val::null()];
    for _ in 0..10 {
        println!("Generating random numbers");
        gen.call(&mut store, &[1_000_000.into()], &mut result)?;
        let arr = result[0].clone();
        println!("Sorting");
        let start = std::time::Instant::now();
        sort.call(&mut store, &[arr], &mut [Val::null()])?;
        let elapsed = start.elapsed();
        println!("Elapsed: {}ms", elapsed.as_millis());
    }

    Ok(())
}
