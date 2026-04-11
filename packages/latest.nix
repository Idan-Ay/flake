{ pkgsLatest, inputs, lib, ... }:

{
  services.ollama = {
    enable = true;
    package = pkgsLatest.ollama-vulkan;
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
    libreoffice

    vscodium

    youtube-tui

    rmpc

    prismlauncher
    protonplus

    signal-desktop
  ]);
}
