{ pkgs, lib, quickshell, ... }:

{
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 8384 25565 ];
    allowedUDPPorts = [ 25565 ];
    # allowedTCPPortRanges = [
      # { from = 1714; to = 1764; }
    # ];
    # allowedUDPPortRanges = [
      # { from = 1714; to = 1764; }
    # ];
  };
  programs.nix-ld.enable = true;
  # Enable Niri (Wayland window manager)
  programs.niri = {
    enable = true;
    useNautilus = true;
  };
  programs.dconf.enable = true;
  services.gnome.gnome-settings-daemon.enable = true;

  programs.gamemode.enable = true;

  services = {
    displayManager.enable = true;
    displayManager.ly.enable = true;
  };

  services.avahi.enable = true;

  services.greetd = {
    enable = true;

    settings = {
      default_session = {
        command = "niri-session";
        user = "idan";
      };
    };
  };

  programs.fish = {
    enable = true;

    loginShellInit = builtins.readFile ../scripts/loginShellInit.fish;
    shellInit = builtins.readFile ../scripts/shellInit.fish;
    interactiveShellInit = builtins.readFile ../scripts/interactiveShellInit.fish;
  };

  zramSwap = {
    enable = true;
    memoryPercent = 15;    # ~4.8GB out of 32GB RAM
    algorithm = "zstd";    # Fast and efficient compression
  };

  environment.systemPackages = lib.mkAfter (with pkgs; [
    xwayland-satellite

    # waybar # Bar
    quickshell.packages.${system}.default
  ]);

  services.getty.autologinUser = "idan";
}
