{ config, pkgs, lib, ... }:

{
  programs.git.enable = true; # Git

  # enable nix-index auto integration with fish
  programs.command-not-found.enable = true;

  environment.systemPackages = lib.mkAfter (with pkgs; [
    home-manager

    foot # terminal

    fd # fast directory search
    ripgrep # Easy file content search
    zoxide # smarter cd

    fastfetch # View system information

    grim # Screenshot tool
    grimblast # Screenshot in window tool
    swappy # Handles screenshot

    lf # file manager
    avfs # archive-as-directories
    p7zip unzip zip unrar atool

    micro # Code editor

    bottom # Task manager

    wl-clipboard # Clipboard support for some programs
  ]);
}
