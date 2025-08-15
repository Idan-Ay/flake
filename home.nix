{ config, pkgs, lib, ... }:

{
  programs.home-manager.enable = true;

  home.username = "idan";
  home.homeDirectory = "/home/idan";
  home.stateVersion = "25.05";

  home.pointerCursor = {
    name = "capitaine-cursors";
    package = pkgs.capitaine-cursors;
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  imports = [
    ./config/anyrun/anyrun.nix
    ./config/theming/gtk.nix
    ./config/theming/qt.nix
  ];
  
  xdg.configFile = { 
    "hypr/hyprland.conf".source = ./config/hypr/hyprland.conf;
    "hypr/UserConfigs" = {
      source = ./config/hypr/UserConfigs;
      recursive = true;
    };
  };
}