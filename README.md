<h1 align="center">Membrane Template</h1>
<div align="center">
  Membrane is an opinionated crate that generates a Dart package from your Rust library. It provides extremely fast performance with strict typing, automatic memory management, and zero copy returns over the FFI boundary via bincode.

  This repository is a quick-start template to provide the minimal Rust needed to get started ([just 3 files!](https://github.com/jerel/membrane_template/tree/main/rust_example)).
</div>

<br />

## Usage

_View the [rust_example](https://github.com/jerel/membrane_template/tree/main/rust_example) directory for a runnable example._

The files of interest are:
* [Cargo.toml](https://github.com/jerel/membrane_template/blob/main/rust_example/Cargo.toml)
* [src/lib.rs](https://github.com/jerel/membrane_template/blob/main/rust_example/src/lib.rs)
* [src/generator.rs](https://github.com/jerel/membrane_template/blob/main/rust_example/src/generator.rs)

Running `cargo build` in the `rust_example` directory compiles the library and running
`cargo run` in the `rust_example` directory produces the `dart_example` directory. You can then
switch to that `dart_example` directory and, while referencing the compiled library, run the Dart CLI application:
`LD_LIBRARY_PATH="../rust_example/target/debug/" dart run` and observe it printing to the console. (On different operating systems you will need to adjust the variable name, for example on MacOS adjusted for dylib:
`DYLD_LIBRARY_PATH="../rust_example/target/debug/" dart run`).
