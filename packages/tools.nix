{ config, pkgs, lib, ... }:

{
  programs.fish.enable = true; # Fish Shell

  programs.git.enable = true; # Git

  programs.zoxide.enable = true; # tracks visited folders, lets you z myproject

  # enable nix-index auto integration with fish
  programs.command-not-found.enable = true;

  environment.systemPackages =  lib.mkAfter [ (with pkgs; [
    kitty # GPU-accelerated terminal

    # playerctl # Media shortcuts

    ddcutil # Control Monitor brightness

    ripgrep # Easy file content search
    fzf # fuzzy finder
    zoxide # smarter cd

    fastfetch # View system information
    
    libqalculate # Calculator

    grim # Screenshot tool
    grimblast # Screenshot in window tool
    swappy # Handles screenshot

    mpv # Image/Media viewer
    
    nnn # File Manager
    p7zip # for .7z/.zip
    atool # for .tar, .gz, etc.

    micro # Code editor

    bottom # Task manager
  ])];
}