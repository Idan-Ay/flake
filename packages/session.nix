{ config, pkgs, lib, inputs, ... }:

{
  # Enable Hyprland (Wayland window manager)
  programs.niri.enable = true;

  environment.systemPackages = lib.mkAfter (with pkgs; [
    swaybg # background

    waybar # Bar
    anyrun # Launcher
  ]);

  # Enable xdg-desktop-portal support (e.g. for file pickers, screenshots)
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];
  };

  # Set up graphical session to auto-start on TTY1 (no display manager like LightDM)
  services.getty.autologinUser = "idan";
  services.displayManager.defaultSession = "Hyprland";
}