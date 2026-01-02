{ pkgsLatest, lib, ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  environment.systemPackages = lib.mkAfter (with pkgsLatest; [
    brave # unfree
    blender
    obsidian
    gimp3
    vscodium
    vivaldi
    discord
  ]);
}
