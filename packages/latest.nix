{ pkgsLatest, lib, ... }:

{
  programs.steam = { # unfree
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  environment.systemPackages = lib.mkAfter (with pkgsLatest; [
    blender
    obsidian
    gimp3
    vivaldi # unfree
    discord # unfree
    prismlauncher
  ]);
}
