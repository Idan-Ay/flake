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

  environment.systemPackages = lib.mkAfter (with pkgsLatest-x86; [
    niri.packages.x86_64-linux.default
    vicinae

    discord

    lutris

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

    anki

    protonplus

    signal-desktop
  ]);
}
