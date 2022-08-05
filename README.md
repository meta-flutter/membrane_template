<h1>Membrane Template</h1>

This repository is a quick-start template for [Membrane](https://github.com/jerel/membrane) to provide the minimal Rust needed to get started ([just 3 files!](./rust_example)).

## Usage

The files of interest are in [rust_example](./rust_example):
* [Cargo.toml](./rust_example/Cargo.toml)
* [src/lib.rs](./rust_example/src/lib.rs)
* [src/generator.rs](./rust_example/src/generator.rs)

Running `cargo build` in the `rust_example` directory compiles the library to the `target` directory and running
`cargo run` in the `rust_example` directory produces the `dart_example` directory. You can then
switch to that `dart_example` directory and, while referencing the compiled library, run the Dart CLI application:
`LD_LIBRARY_PATH="../rust_example/target/debug/" dart run` and observe it printing to the console. (On different operating systems you will need to adjust the variable name, for example on MacOS adjusted for dylib:
`DYLD_LIBRARY_PATH="../rust_example/target/debug/" dart run`).

### Flutter Usage

The [dart_example](./dart_example) directory is a minimal pub dependency which can easily be consumed by any Flutter application. To observe a basic Flutter application change to the `flutter_example` directory on your favorite platform and execute `flutter run`.
