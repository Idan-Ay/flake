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

    ./config/fish.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  home-manager.users.idan = import ./home.nix;
  
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

  zramSwap = {
    enable = true;
    memoryPercent = 15;    # ~4.8GB out of 32GB RAM
    algorithm = "zstd";    # Fast and efficient compression
  };

  users.defaultUserShell = pkgs.fish;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  security.sudo.enable = true;

  boot.initrd.supportedFilesystems = [ "ext4" ];
  fileSystems."/" = {
    device = "/dev/nvme0n1p5";
    fsType = "ext4";
  };
  fileSystems."/boot" = {
    device = "/dev/nvme0n1p1";
    fsType = "vfat";
  };
}