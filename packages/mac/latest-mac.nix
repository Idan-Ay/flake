{ pkgsLatest-arm, lib, niri, ... }:

{
  services.ollama = {
    enable = true;
    package = pkgsLatest-arm.ollama-vulkan;
  };
  services.open-webui = {
    enable = true;
    openFirewall = false;
    environment = {
      ANONYMIZED_TELEMETRY = "False";
      DO_NOT_TRACK = "True";
      SCARF_NO_ANALYTICS = "True";
      WEBUI_AUTH = "False";
      WEB_SEARCH_ENGINE = "searxng";
      SEARXNG_QUERY_URL = "https://search.iayache.com/search?q=<query>&format=json";
      WEB_SEARCH_RESULT_COUNT = "5";
      WEB_SEARCH_CONCURRENT_REQUESTS = "24";
    };
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
