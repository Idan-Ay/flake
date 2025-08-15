{ config, pkgs, lib, ... }:

{
  programs.home-manager.enable = true;

  home.username = "idan";
  home.homeDirectory = "/home/idan";
  home.stateVersion = "25.05";

  imports = [
    ./config/anyrun/anyrun.nix
  ];
  
  xdg.configFile = { 
    "hypr/hyprland.conf".source = ./config/hypr/hyprland.conf;
    "hypr/UserConfigs" = {
      source = ./config/hypr/UserConfigs;
      recursive = true;
    }
  };
}