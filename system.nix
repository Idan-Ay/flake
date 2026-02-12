{ pkgs, ... }:

{
  networking.hostName = "idan-pc-l";
  imports = [
    ./user.nix
    
    ./hardware-configuration.nix

    ./packages/tools.nix
    ./packages/drivers.nix
    ./packages/latest.nix
    ./packages/session.nix
    ./packages/sound.nix
    ./packages/fonts.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "25.05";
}
