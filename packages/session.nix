{ config, pkgs, lib, inputs, ... }:

{
  # Enable Niri (Wayland window manager)
  programs.niri.enable = true;

  environment.systemPackages = lib.mkAfter (with pkgs; [
    xwayland-satellite # Xwayland outside your Wayland compositor

    swaybg # Wallpaper

    waybar # Bar
    anyrun # Launcher
  ]);

  # Enable xdg-desktop-portal support (e.g. for file pickers, screenshots)
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = [ "wlr" "gtk" ];
  };

  services.getty.autologinUser = "idan";
}
