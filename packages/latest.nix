{ config, pkgsLatest, lib, ... }:

{
  environment.systemPackages = lib.mkAfter (with pkgsLatest; [
    brave # unfree
    obsidian
    gimp3
    vscodium
    vivaldi
  ]);
}