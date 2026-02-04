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
    discord # unfree
    godot
    gdlauncher-carbon
    kdePackages.kdenlive
    krita
    inputs.quickshell.packages.${system}.default
  ]);
}
