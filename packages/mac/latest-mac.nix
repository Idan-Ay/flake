{ pkgsLatest-arm, lib, niri, ... }:

{
  services.ollama = {
    enable = true;
    package = pkgsLatest-arm.ollama-vulkan;
  };

  programs.firefox = {
    enable = true;
    package = pkgsLatest-arm.firefox;
  };

  environment.systemPackages = lib.mkAfter (with pkgsLatest-arm; [
    niri.packages.aarch64-linux.default
    swayidle
    vicinae

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

    rpi-imager

    anki

    prismlauncher

    signal-desktop
  ]);
}
