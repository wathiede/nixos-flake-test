{ pkgs, ... }:

{
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/null";
  boot.kernelParams = [ "nomodeset" ];
  networking.useDHCP = false;
  networking.interfaces.ens3.useDHCP = true;

  networking.hostName = "my-nixos";
  system.stateVersion = "24.05";

  # This package should be built for use and added into pkgs if flake.nix is correct.
  environment.systemPackages = with pkgs; [ nixos-rust-test ];
}
