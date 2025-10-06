{ config, pkgs, lib, inputs, ... }:

{
  programs.git.enable = true; # Git

  # enable nix-index auto integration with fish
  programs.command-not-found.enable = true;

  services.gvfs.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        FastConnectable = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };
  services.blueman.enable = true;

  networking.networkmanager.enable = true;

  services.gnome.gnome-keyring.enable = false;

  environment.systemPackages = lib.mkAfter (with pkgs; [
    home-manager

    foot # terminal

    fd # fast directory search
    ripgrep # Easy file content search
    zoxide # smarter cd

    fastfetch # View system information

    lf # file manager
    avfs # archive-as-directories
    p7zip unzip zip unrar atool

    xfce.thunar # gui file manager
    xfce.thunar-archive-plugin  # lets Thunar open/extract zip/tar/etc.
    xarchiver

    micro # Code editor

    bottom # Task manager

    wl-clipboard # Clipboard support for some programs

    playerctl # Media shortcuts

    imagemagickBig # Create, edit, compose, or convert bitmap images

    glib # C library of programming buildings blocks

    cliphist # Wayland clipboard manager
  ]);
}
