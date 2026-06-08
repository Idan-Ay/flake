{ pkgsLatest-arm, lib, niri, ... }:

{
  services.ollama = {
    enable = true;
    package = pkgsLatest-arm.ollama-cuda;
  };
  services.open-webui = {
    enable = true;
    openFirewall = false;
    environment = {
      ANONYMIZED_TELEMETRY = "False";
      DO_NOT_TRACK = "True";
      SCARF_NO_ANALYTICS = "True";
      WEBUI_AUTH = "False";
    };
  };

  environment.systemPackages = lib.mkAfter (with pkgsLatest-arm; [
    niri.packages.aarch64-linux.default
    swayidle
    vicinae
    brightnessctl

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

    rpi-imager

    anki

    signal-desktop
  ]);
}
