{ pkgs, lib, quickshell, ... }:

{
  programs.nix-ld.enable = true;
  # Enable Niri (Wayland window manager)
  programs.niri = {
    enable = true;
    useNautilus = true;
  };

  programs.gamemode.enable = true;

  services = {
    displayManager.enable = true;
    displayManager.ly.enable = true;
  };


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

  # services.libinput = {
    # enable = true;

    # mouse = {
      # scrollMethod = "button";
      # scrollButton = 274; # BTN_MIDDLE
    # };
  # };

  environment.systemPackages = lib.mkAfter (with pkgs; [
    xwayland-satellite

    # waybar # Bar
    quickshell.packages.${system}.default
  ]);

  services.getty.autologinUser = "idan";
}
