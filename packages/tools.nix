{ config, pkgs, lib, ... }:

{
  programs.fish.enable = true; # Fish Shell

  programs.git.enable = true; # Git

  # enable nix-index auto integration with fish
  programs.command-not-found.enable = true;

  environment.systemPackages = lib.mkAfter (with pkgs; [
    foot # terminal

    anyrun # launcher

    playerctl # Media shortcuts

    fd # fast directory search
    ripgrep # Easy file content search
    zoxide # smarter cd

    fastfetch # View system information

    grim # Screenshot tool
    grimblast # Screenshot in window tool
    swappy # Handles screenshot

    mpv # Image/Media viewer
    
    nnn # File Manager
    p7zip # for .7z/.zip
    atool # for .tar, .gz, etc.

    micro # Code editor

    bottom # Task manager
  ]);
}
