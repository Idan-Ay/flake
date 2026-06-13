{ config, lib, ... }:
{
  programs.librewolf = {
    enable = true;

    languagePacks = [
      "en-US"
      "en-GB"
      "de"
    ];

    policies = {

      Cookies = "reject-foreign";

      SearchEngines = {
        Add = [
          {
            "Name" = "SearXNG";
            "URLTemplate" = "https://search.iayache.com/search?q={searchTerms}";
            "Alias" = "sx";
          }
          {
            "Name" = "Ecosia Search";
            "URLTemplate" = "https://www.ecosia.org/search?method=index&q={searchTerms}";
            "Alias" = "es";
          }
          {
            "Name" = "Brave Search";
            "URLTemplate" = "https://search.brave.com/search?q={searchTerms}&summary=0";
            "IconURL" = "https://cdn.search.brave.com/serp/v1/static/brand/eebf5f2ce06b0b0ee6bbd72d7e18621d4618b9663471d42463c692d019068072-brave-lion-favicon.png";
            "Alias" = "brave";
          }
          {
            "Name" = "OpenStreetMap";
            "URLTemplate" = "https://www.openstreetmap.org/search?query={searchTerms}";
            "IconURL" = "https://www.openstreetmap.org/favicon.ico";
            "Alias" = "osm";
          }
          {
            "Name" = "Nix Packages";
            "URLTemplate" = "https://search.nixos.org/packages?channel=25.11&query={searchTerms}";
            "IconURL" = "https://search.nixos.org/images/nix-logo.png";
            "Alias" = "np";
          }
          {
            "Name" = "Nix Options";
            "URLTemplate" = "https://search.nixos.org/options?channel=25.11&query={searchTerms}";
            "IconURL" = "https://search.nixos.org/images/nix-logo.png";
            "Alias" = "no";
          }
        ];
        Default = "SearXNG";
      };

      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          default_area = "menupanel";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };
        "{d7742d87-e61d-4b78-b8a1-b469842139fa}" = {
          default_area = "menupanel";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/vimium-ff/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };
      };
    };
    settings = let
      ffVersion = config.programs.librewolf.package.version;
    in {
      "media.ffmpeg.vaapi.enabled" = lib.versionOlder ffVersion "137.0.0";
      "media.hardware-video-decoding.force-enabled" = lib.versionAtLeast ffVersion "137.0.0";
      "media.rdd-ffmpeg.enabled" = lib.versionOlder ffVersion "97.0.0";

      "gfx.x11-egl.force-enabled" = true;
      "widget.dmabuf.force-enabled" = true;

      "media.av1.enabled" = true;

      "browser.tabs.closeWindowWithLastTab" = false;
      "sidebar.verticalTabs" = true;
      "ui.systemUsesDarkTheme" = 1;
      "browser.toolbars.bookmarks.visibility" = "never";

      "widget.use-xdg-desktop-portal.file-picker" = 1;

      "privacy.resistFingerprinting" = false;
      "privacy.clearOnShutdown_v2.cookiesAndStorage" = false;
    };
  };
}
