{ pkgsLatest-arm, lib, niri, ... }:

{
  services.ollama = {
    enable = true;
    package = pkgsLatest-arm.ollama-vulkan;
  };

  environment.systemPackages = lib.mkAfter (with pkgsLatest-arm; [
    niri.packages.aarch64-linux.default

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

    prismlauncher

    youtube-tui
    impala
    rmpc

    signal-desktop
  ]);
}
