{ pkgs, ... }:

{
  networking.hostName = "idan-mac-l";
  imports = [
    ./user.nix
    
    ./hardware-configuration-mac.nix

    ./packages/tools.nix
    ./packages/mac.nix
    ./packages/mac/latest.nix
    ./packages/session.nix
    ./packages/sound.nix

    apple-silicon.nixosModules.apple-silicon-support
  ];

  nixpkgs.overlays = [ apple-silicon.overlays.default ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = { 
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = false;
  };
  
  hardware.asahi = {
    peripheralFirmwareDirectory = ./firmware;
    useExperimentalGPUDriver = true;
    withRust = true;
    experimentalGPUInstallMode = "replace";
  };

  system.stateVersion = "25.05";
}
