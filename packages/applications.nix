{ config, pkgs, lib, ... }:

{
  environment.systemPackages = lib.mkAfter (with pkgs; [
    google-chrome # unfree
    blender
    obsidian
    gimp3
    vscode # unfree
  ]);
}