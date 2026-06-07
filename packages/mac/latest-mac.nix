{ pkgsLatest-arm, lib, niri, ... }:

{
  environment.systemPackages = lib.mkAfter (with pkgsLatest-arm; [
    niri.packages.aarch64-linux.default
    swayidle
    vicinae
    brightnessctl

    obsidian # unfree

    opencode

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

    rpi-imager

    anki

    signal-desktop
  ]);
}
