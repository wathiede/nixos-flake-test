# Build with:
# nixos-rebuild build --flake .#my-nixos
{
  description = "A flake example building NixOS with a custom rust package";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, rust-overlay, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        inherit inputs;
        config = { allowUnfree = true; };
        overlays = [ (import ./pkgs/all-packages.nix) (import rust-overlay) ];
      };
      customRustPlatform = pkgs.callPackage ./pkgs/customRustPlatform.nix { };
    in {
      nixosConfigurations.my-nixos = nixpkgs.lib.nixosSystem {
        inherit pkgs;
        inherit system;
        modules = [
          ./configuration.nix
          {
            nixpkgs.overlays =
              [ (final: prev: { inherit customRustPlatform; }) ];
          }
        ];
      };
    };
}
