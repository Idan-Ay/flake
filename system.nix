{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  # Import modular config files
  imports = [
    ./hardware-configuration.nix

    ./packages/tools.nix
    ./packages/drivers.nix
    ./packages/applications.nix
    ./packages/session.nix
    ./packages/sound.nix
    ./packages/theming.nix
    ./packages/interception-tools.nix

    ./config/hyprland.nix
    ./config/fish.nix
    ./config/kitty.nix
  ];

  
  networking.hostName = "idan-pc-l";
  time.timeZone = "Europe/Berlin";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
        LC_TIME = "de_DE.UTF-8";        # German-style dates (e.g. 26.07.2025)
        LC_MONETARY = "de_DE.UTF-8";    # Currency: € instead of $
        LC_MEASUREMENT = "de_DE.UTF-8"; # Optional: metric instead of imperial
        LC_NUMERIC = "en_US.UTF-8";     # Optional: keeps dot (.) as decimal separator
    };
  };
  console.keyMap = "us";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  users.defaultUserShell = pkgs.fish;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  security.sudo.enable = true;
}