{
  networking.hostName = "idan-mac-l";
  imports = [
    ./user.nix

    ./hardware-configuration-mac.nix

    ./packages/tools.nix
    ./packages/mac/latest-mac.nix
    ./packages/session.nix
    ./packages/mac/session-mac.nix
    ./packages/sound.nix
    ./packages/fonts.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  hardware.asahi.peripheralFirmwareDirectory = ./firmware-mac;

  system.stateVersion = "25.05";
}
