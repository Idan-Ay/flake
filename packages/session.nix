{ config, pkgs, lib, inputs, quickshell, ... }:

{
  # Enable Niri (Wayland window manager)
  programs.niri.enable = true;

  environment.systemPackages = lib.mkAfter (with pkgs; [
    xwayland

    preload # Makes applications run faster by prefetching binaries and shared objects

    # waybar # Bar
    quickshell.packages.${system}.default
  ]);

  # Enable xdg-desktop-portal support (e.g. for file pickers, screenshots)
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
    config.common.default = [ "wlr" "gtk" "gnome" ];
  };

  services.getty.autologinUser = "idan";
}
