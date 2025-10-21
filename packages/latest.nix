{ config, pkgsLatest, lib, ... }:

{
  environment.systemPackages = lib.mkAfter (with pkgsLatest; [
    brave # unfree
    blender
    obsidian
    gimp3
    vscodium
  ]);
}