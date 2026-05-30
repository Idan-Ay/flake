{ ... }:

{
  networking.hostName = "idan-pc-l";
  imports = [
    ./user.nix

    ./hardware-configuration-pc.nix

    ./packages/tools.nix
    ./packages/pc/drivers-pc.nix
    ./packages/pc/latest-pc.nix
    ./packages/pc/session-pc.nix
    ./packages/session.nix
    ./packages/sound.nix
    ./packages/fonts.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "25.05";
}
