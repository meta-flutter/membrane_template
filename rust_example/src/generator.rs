use rust_example as _;

fn main() {
    let mut project = membrane::Membrane::new();
    project
        .timeout(200)
        .package_destination_dir("../dart_example")
        .package_name("dart_example")
        .using_lib("librust_example")
        .create_pub_package()
        .write_api()
        .write_c_headers()
        .write_bindings();
}
