{ config, pkgs, lib, ... }:

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

  environment.systemPackages =  lib.mkAfter [ (with pkgs; [
    quickshell
  ])];

  # Make Hyprland start on login to TTY1
  systemd.user.services.hyprland-session = {
    enable = true;
    description = "Start Hyprland on TTY1 login";
    wantedBy = [ "default.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.hyprland}/bin/Hyprland";
      Restart = "always";
      Environment = [
        "XDG_CURRENT_DESKTOP=Hyprland"
        "XDG_SESSION_TYPE=wayland"
        "QT_QPA_PLATFORM=wayland"
        "GDK_BACKEND=wayland,x11"
        "NIXOS_OZONE_WL=1"
      ];
    };
  };
}
