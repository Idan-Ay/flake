{ config, lib, inputs, pkgs, ... }:


{
  programs.librewolf = {
    enable = true;

    languagePacks = [
      "en-US"
      "en-GB"
      "de"
    ];

    profiles.default = {
      isDefault = true;
      name = "default";
      path = "default";
    };

    policies = {

      Cookies = "reject-foreign";

      SearchEngines = {
        Add = [
          {
            "Name" = "Ecosia Search";
            "URLTemplate" = "https://www.ecosia.org/search?method=index&q={searchTerms}";
            "Alias" = "es";
          }
          {
            "Name" = "SearXNG";
            "URLTemplate" = "https://search.iayache.com/search?q={searchTerms}";
            "Alias" = "sx";
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
        "{3c078156-979c-498b-8990-85f7987dd929}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/sidebery/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };
        "newtaboverride@agenedia.com" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/new-tab-override/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };
        "addon@darkreader.org" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };
        "{ce9f4b1f-24b8-4e9a-9051-b9e472b1b2f2}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/clear-browsing-data/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };
        "{3579f63b-d8ee-424f-bbb6-6d0ce3285e6a}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/chameleon-ext/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };
        "jid1-MnnxcxisBPnSXQ@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
          installation_mode = "force_installed";
          private_browsing = true;
        };
        "foxyproxy@eric.h.jung" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/foxyproxy-standard/latest.xpi";
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

      "gfx.x11-egl.force-enabled" = true;
      "widget.dmabuf.force-enabled" = true;

      "media.av1.enabled" = true;

      "browser.tabs.closeWindowWithLastTab" = false;
      "ui.systemUsesDarkTheme" = 1;
      "browser.toolbars.bookmarks.visibility" = "never";

      "widget.use-xdg-desktop-portal.file-picker" = 1;

      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      "svg.context-properties.content.enabled" = true;
      "layers.acceleration.force-enabled" = true;
      "gfx.webrender.all" = true;
      "gfx.webrender.enabled" = true;

      "privacy.resistFingerprinting" = true;
      "privacy.clearOnShutdown_v2.cookiesAndStorage" = true;

      "browser.tabs.allow_transparent_browser" = true;

      "cookiebanners.service.mode.privateBrowsing" = 2; # Block cookie banners in private browsing
      "cookiebanners.service.mode" = 2; # Block cookie banners

      "privacy.donottrackheader.enabled" = true;

      "privacy.trackingprotection.emailtracking.enabled" = true;
      "privacy.trackingprotection.enabled" = true;
      "privacy.trackingprotection.fingerprinting.enabled" = true;
      "privacy.trackingprotection.socialtracking.enabled" = true;

      "media.peerconnection.enabled" = false;
      "privacy.firstparty.isolate" = true;
      "dom.webaudio.enabled" = false;
      "webgl.disabled" = true;
    };
  };

  home.file = {
    ".librewolf/default/chrome" = {
      source = inputs.user-chrome;
      recursive = true;
    };
    ".librewolf/default/user.js".text = let
      extraJS = ''

        // Extra config
        user_pref("browser.startup.page", 3);
        user_pref("browser.startup.homepage", "http://localhost");
      '';
    in
      builtins.readFile "${pkgs.arkenfox-userjs}/user.js" + extraJS;
  };
}
