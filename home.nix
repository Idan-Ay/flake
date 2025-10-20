{ config, pkgs, lib, inputs, ... }:

{
  programs.home-manager.enable = true;

  home.username = "idan";
  home.homeDirectory = "/home/idan";
  home.stateVersion = "25.05";

  imports = [
    ./config/anyrun/anyrun.nix
    ./config/theming/theming.nix
  ];
  
  xdg.configFile = { 
    "foot/foot.ini".source = ./config/foot.ini;

    "waybar" = {
      source = ./config/waybar;
      recursive = true;
    };

    "lf/lfrc".source = ./config/lfrc;

    "wallpapers" = {
      source = ./config/wallpapers;
      recursive = true;
    };

    # "mimeapps.list".source = ./config/mimeapps.list;

    "niri/config.kdl".source = ./config/niri/config.kdl;

    "quickshell" = {
      source = ./config/DankMaterialShell-master;
      recursive = true;
    };

    "better-control/settings.json".source = ./config/better-control/settings.json;
  };
}