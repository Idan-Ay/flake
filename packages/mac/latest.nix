{ pkgsLatestMac, lib, ... }:

{
  programs.steam = { # unfree
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  environment.systemPackages = lib.mkAfter (with pkgsLatestMac; [
    blender
    obsidian
    godot
    krita
    prismlauncher
    discord # unfree
    # davinci-resolve # unfree
  ]);
}
