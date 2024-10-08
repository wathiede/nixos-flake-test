# Build with:
# nixos-rebuild build --flake .#my-nixos
{
  description = "A flake example building NixOS with a custom rust package";

  inputs = { nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05"; };

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
        overlays = [ (import ./pkgs/all-packages.nix) ];
      };

    in {
      nixosConfigurations.my-nixos = nixpkgs.lib.nixosSystem {
        inherit pkgs;
        inherit system;
        modules = [ ./configuration.nix ];
      };
    };
}
