{ pkgs, lib, ... }:

{
  programs.git.enable = true; # Git

  services.gvfs.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        FastConnectable = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };

  networking.networkmanager.enable = true;

  services.udisks2.enable = true;

  services.ollama = {
    enable = true;
    package = pkgs.ollama-vulkan;
    loadModels = [
      "drivedenpadev/deepseek-v3.2"
    ];
  };

  programs.nix-ld.enable = true;

  programs.java.enable = true;

  programs.nautilus-open-any-terminal = {
    enable = true;
    terminal = "foot";
  };
  services.gnome.sushi.enable = true;

  environment.systemPackages = lib.mkAfter (with pkgs; [
    home-manager

    gh

    # valent # Gui tool for kde connect

    foot # terminal

    fd # fast directory search
    ripgrep # Easy file content search
    zoxide # smarter cd

    hyprpicker # Hyprland color picker

    toybox

    walker # launcher

    fastfetch # View system information

    lf # file manager
    avfs # archive-as-directories
    p7zip unzip zip unrar atool

    nautilus # Graphical file manager
    kdePackages.dolphin

    bottom # Terminal task manager

    wl-clipboard # Clipboard support for some programs

    playerctl # Media shortcuts

    imagemagickBig # Create, edit, compose, or convert bitmap images

    glib # C library of programming buildings blocks

    cliphist # Wayland clipboard manager

    python3

    jq

    mesa-demos
  ]);
}
