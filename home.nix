{ config, pkgs, ... }:

{
  home.username = "idan";
  home.homeDirectory = "/home/idan";

  programs.home-manager.enable = true;

  xdg.configFile = {
    "kitty/kitty.conf".source = ./config/kitty.conf;
    "hypr/hyprland.conf".source = ./config/hyprland.conf;
  };
}