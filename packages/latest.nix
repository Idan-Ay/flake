{ pkgsLatest, inputs, lib, ... }:

{
  programs.steam = { # unfree
    enable = true;

    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;

    protontricks.enable = true;
    gamescopeSession.enable = true;
  };

  environment.systemPackages = lib.mkAfter (with pkgsLatest; [
    qutebrowser
    python313Packages.adblock

    obsidian # unfree
    affine

    blender
    godot
    gimp
    krita
    inkscape
    kdePackages.kdenlive
    audacity
    onlyoffice-desktopeditors

    vscodium

    youtube-tui

    rmpc

    prismlauncher
    protonplus

    signal-desktop

    sassc
    gnumake
    gnused
    glib.dev
    sbclPackages.cl-cffi-gtk-gdk-pixbuf
    librsvg
    bc
  ]);
}
