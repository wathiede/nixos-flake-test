{ pkgs, makeRustPlatform }:
let
  rust_targets = [
    "aarch64-linux-android"
    "arm-linux-androideabi"
    "armv7-linux-androideabi"
    "thumbv7neon-linux-androideabi"
    "wasm32-unknown-unknown"
  ];
  rust = pkgs.rust-bin.nightly.latest.default.override {
    extensions = [ "rust-src" ];
    targets = rust_targets;
  };
in makeRustPlatform {
  cargo = rust;
  rustc = rust;
}
