{ pkgsLatest, lib, ... }:

{
  programs.steam = { # unfree
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  programs.steam.protontricks.enable = true;

  environment.systemPackages = lib.mkAfter (with pkgsLatest; [
    blender
    obsidian
    godot
    krita
    prismlauncher
    protonplus
    discord # unfree
    davinci-resolve # unfree
  ]);
}
