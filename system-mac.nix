{ pkgs, apple-silicon, ... }:

{
  networking.hostName = "idan-mac-l";
  imports = [
    ./user.nix
    
    ./hardware-configuration-mac.nix

    ./packages/tools.nix
    ./packages/mac/latest.nix
    ./packages/session.nix
    ./packages/sound.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = { 
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = false;
  };

  system.stateVersion = "25.05";
}
