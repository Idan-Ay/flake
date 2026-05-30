{ pkgsLatest-x86, lib, niri, ... }:

{
  programs.steam = { # unfree
    enable = true;
    package = pkgsLatest-x86.steam;

    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;

    protontricks.enable = true;
    gamescopeSession.enable = true;
  };

  environment.systemPackages = lib.mkAfter (with pkgsLatest-x86; [
    niri.packages.x86_64-linux.default

    lutris

    obsidian # unfree
    joplin-cli

    rmpc

    blender
    godot
    gimp
    krita
    inkscape
    kdePackages.kdenlive
    audacity
    libreoffice
    focuswriter

    vscodium

    anki

    prismlauncher
    protonplus

    signal-desktop
  ]);
}
