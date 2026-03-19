{ pkgsLatest, inputs, lib, ... }:

{
  programs.steam = { # unfree
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
  programs.steam.protontricks.enable = true;

  environment.systemPackages = lib.mkAfter (with pkgsLatest; [
    blender
    obsidian # unfree
    affine
    godot
    krita
    prismlauncher
    protonplus
    vscodium
    onlyoffice-desktopeditors
    kdePackages.kdenlive
    youtube-tui
    gimp
    audacity
    rmpc # tui music player
    qutebrowser
    python313Packages.adblock
  ]);
}
