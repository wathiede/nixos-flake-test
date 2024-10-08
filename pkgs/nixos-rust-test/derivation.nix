{ lib, rustPlatform, fetchFromGitHub }:

rustPlatform.buildRustPackage rec {
  pname = "nixos-rust-test";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "wathiede";
    repo = "nixos-rust-test";
    rev = "HEAD";
    hash = "sha256-kxBOVYg5xY+/SXfnmHa8N09ydR3SxxOsm/XizX/YR5Q=";
  };

  cargoLock = { lockFile = src + "/Cargo.lock"; };

  meta = with lib; {
    description = "Program to test building rust packages under NixOS + flake";
    homepage = "https://github.com/wathiede/nixos-rust-test.git";
    license = licenses.unfree;
    maintainers = [ "nix@xinu.tv" ];
  };
}
