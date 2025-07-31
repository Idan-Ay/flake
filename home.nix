{ config, pkgs, ... }:

{
  home.username = "idan";
  home.homeDirectory = "/home/idan";

  programs.home-manager.enable = true;

  home.stateVersion = "25.05";

  xdg.configFile = {
    "kitty/kitty.conf".source = ./config/kitty.conf;
    "hypr/hyprland.conf".source = ./config/hyprland.conf;
  };
}