{ pkgsLatest-arm, lib, niri, ... }:

{
  services.ollama = {
    enable = true;
    package = pkgsLatest-arm.ollama-vulkan;
  };

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
