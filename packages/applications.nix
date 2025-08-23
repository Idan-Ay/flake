{ config, pkgs, lib, ... }:

{
  environment.systemPackages = lib.mkAfter (with pkgs; [
    brave # unfree
    blender
    obsidian
    gimp3
    vscode # unfree
  ]);
}