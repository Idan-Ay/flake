{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    google-chrome    # unfree
    blender
    obsidian
    gimp3
    chatgpt
    vscode
  ];
}