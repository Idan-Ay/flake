{ config, pkgs, lib, inputs, ... }:

{
  # Enable Hyprland (Wayland window manager)
  programs.hyprland.enable = true;

  # Enable xdg-desktop-portal support (e.g. for file pickers, screenshots)
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  # Set up graphical session to auto-start on TTY1 (no display manager like LightDM)
  services.getty.autologinUser = "idan";
  services.displayManager.defaultSession = "Hyprland";
}