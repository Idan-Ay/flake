{ config, pkgs, lib, inputs, ... }:

{
  programs.home-manager.enable = true;

  home.username = "idan";
  home.homeDirectory = "/home/idan";
  home.stateVersion = "25.05";

  imports = [
    ./config/anyrun/anyrun.nix
    ./config/theming.nix
  ];
  
  xdg.configFile = { 
    "hypr/hyprland.conf".source = ./config/hypr/hyprland.conf;
    "hypr/UserConfigs" = {
      source = ./config/hypr/UserConfigs;
      recursive = true;
    };

    "foot/foot.ini".source = ./config/foot.ini;

    "ironbar/config.json".source = ./config/ironbar.json;
  };
}