{ nixos-apple-silicon, ... }:

{
  networking.hostName = "idan-pc-l";
  imports = [
    ./user.nix

    ./hardware-configuration-mac.nix

    ./packages/tools.nix
    ./packages/latest.nix
    ./packages/session.nix
    ./packages/sound.nix
    ./packages/fonts.nix

				<apple-silicon-support/apple-silicon-support>
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "25.05";
}
