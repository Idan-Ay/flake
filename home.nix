{ config, pkgs, lib, ... }:

{
  programs.home-manager.enable = true;

  home.username = "idan";
  home.homeDirectory = "/home/idan";
  home.stateVersion = "25.05";
  
  xdg.configFile = {
    "kitty/kitty.conf".source = ./config/kitty.conf;
    "hypr/hyprland.conf".source = ./config/hyprland.conf;
  };
}
