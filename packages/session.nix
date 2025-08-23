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

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "niri";
    XDG_CURRENT_DESKTOP = "niri";
    GSK_RENDERER = "gl";
  };

  services.getty.autologinUser = "idan";
}
