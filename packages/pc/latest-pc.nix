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

  services.ollama = {
    enable = true;
    package = pkgsLatest-x86.ollama-cuda;
  };

  environment.systemPackages = lib.mkAfter (with pkgsLatest-x86; [
    niri.packages.x86_64-linux.default
    vicinae

    ladybird

    discord

    lutris

    obsidian # unfree

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

    # Games
    the-powder-toy
    osu-lazer

    anki

    protonplus

    signal-desktop
  ]);
}
