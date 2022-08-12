use std::fs::{read_to_string, write};

fn main() {
    // call this function to keep macos from stripping out "unused" code
    rust_example::load();

    let path = std::path::Path::new("../dart_example");

    let mut project = membrane::Membrane::new();
    project
        .timeout(200)
        .package_destination_dir(path)
        .package_name("dart_example")
        .using_lib("librust_example")
        .create_pub_package()
        .write_api()
        .write_c_headers()
        .write_bindings();

    let plugin_config = r#"
flutter:
  plugin:
    platforms:
      macos:
        pluginClass: DartExamplePlugin
"#;
    let pubspec = read_to_string(path.join("pubspec.yaml")).unwrap();

    write(path.join("pubspec.yaml"), pubspec + plugin_config)
        .expect("dart_example pubspec could not be written");

    // unlink the symlinks because they might be stale
    let _ = std::fs::remove_file(path.join("librust_example.so"));
    let _ = std::fs::remove_file(path.join("macos/librust_example.dylib"));
    // link the compiled artifacts to the plugin folder
    let _ = std::fs::hard_link(
        "./target/debug/librust_example.so",
        path.join("librust_example.so"),
    );
    let _ = std::fs::hard_link(
        "./target/debug/librust_example.dylib",
        path.join("macos/librust_example.dylib"),
    );
}
