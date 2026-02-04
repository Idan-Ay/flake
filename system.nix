{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  # Import modular config files
  imports = [
    ./hardware-configuration.nix

    ./packages/tools.nix
    ./packages/drivers.nix
    ./packages/latest.nix
    ./packages/session.nix
    ./packages/sound.nix
    ./packages/fonts.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  services.greetd = {
    enable = true;

    settings = {
      default_session = {
        command = "niri-session";
        user = "idan";
      };
    };
  };

  xdg.mime.defaultApplications = {
    "inode/directory" = "pcmanfm.desktop";
  };

  users.users.idan = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "input" ];
    shell = pkgs.fish;
  };
  
  networking.hostName = "idan-pc-l";
  time.timeZone = "Europe/Berlin";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
        LC_TIME = "de_DE.UTF-8";        # German-style dates (e.g. 26.07.2025)
        LC_MONETARY = "de_DE.UTF-8";    # Currency: € instead of $
        LC_MEASUREMENT = "de_DE.UTF-8"; # metric instead of imperial
        LC_NUMERIC = "en_US.UTF-8";     # keeps dot (.) as decimal separator
    };
  };
  console.keyMap = "us";

  users.defaultUserShell = pkgs.fish;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  security.sudo.enable = true;

  system.stateVersion = "25.05";
}
