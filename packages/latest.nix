{ pkgsLatest, lib, ... }:

{
  services.ollama = {
    enable = true;
    package = pkgsLatest.ollama-vulkan;
  };

  programs.steam = { # unfree
    enable = true;
    package = pkgsLatest.steam;

    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;

    protontricks.enable = true;
    gamescopeSession.enable = true;
  };

  environment.systemPackages = lib.mkAfter (with pkgsLatest; [
    lutris

    qutebrowser
    python313Packages.adblock

    obsidian # unfree
    logseq
    affine

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

    youtube-tui

    rmpc

    prismlauncher
    protonplus

    signal-desktop
  ]);
}
