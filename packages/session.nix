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

  services.getty.autologinUser = "idan";
}
