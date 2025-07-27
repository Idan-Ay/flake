{ config, pkgs, ... }:

{
  programs.git.enable = true;

  programs.fish.enable = true;

  # enable nix-index auto integration with fish
  programs.command-not-found.enable = true;
}