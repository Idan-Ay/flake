{ pkgsLatest, inputs, lib, ... }:

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
    discord # unfree
    godot
    gdlauncher-carbon
    inputs.quickshell.packages.${system}.default
  ]);
}
