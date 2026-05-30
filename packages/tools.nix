{ pkgs, lib, config, ... }:

{
  programs.git.enable = true;
  security.rtkit.enable = true;

  programs.java = {
    enable = true;
    package = pkgs.javaPackages.compiler.temurin-bin.jre-25;
  };

  virtualisation.docker.enable = true;

  programs.gamemode.enable = true;

  programs.noisetorch.enable = true;

  nixpkgs.overlays = [
    (final: prev: {
      yt-dlp = prev.yt-dlp.overrideAttrs (old: {
        src = prev.fetchFromGitHub {
          owner = "yt-dlp";
          repo = "yt-dlp";
          rev = "master";
          hash = "sha256-BPZzMT1IrZvgva/m5tYMaDYoUaP3VmpmcYeOUOwuoUY=";
        };
      });
    })
  ];

  programs.yazi = {
    enable = true;
    package = (pkgs.yazi.override {
      _7zz = pkgs._7zz-rar;  # Support for RAR extraction
    });
    plugins = {
      inherit (pkgs.yaziPlugins) wl-clipboard;
    };
    #initLua = ./init.lua
    settings = {
      # yazi = lib.importTOML ./settings.toml;
      keymap = lib.importTOML ../config/yazi/keymap.toml;
      theme = lib.importTOML ../config/yazi/theme.toml;
    };
  };

  programs.firefox = {

    languagePacks = [
      "en-US"
      "en-GB"
      "de"
    ];

    policies = {
      #### DEBLOAT ###
      DisableFirefoxStudies = true;
      DisableFirefoxScreenshots = true;
      UserMessaging = {
          ExtensionRecommendations = false;
          UrlbarInterventions = false;
          SkipOnboarding = true;
          MoreFromMozilla = false;
          FirefoxLabs = true;
      };
      FirefoxSuggest = {
          WebSuggestions = false;
          SponsoredSuggestions = false;
          ImproveSuggest = false;
          Locked = true;
      };

      #### SECURITY ###
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;
      HttpsOnlyMode = "force_enabled";
      SSLVersionMin = "tls1.2";
      PostQuantumKeyAgreementEnabled = true;
      HttpAllowlist = [
          "http://localhost"
          "http://127.0.0.1"
      ];

      #### PRIVACY ###
      DisableTelemetry = true;
      EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Exceptions = [
              "https://amazon.de"
          ];
      };

      Cookies = "reject-foreign";

      SearchEngines = {
        Remove = [
          "eBay"
          "Google"
          "Bing"
          # "Ecosia"
          # "Wikipedia"
          "Perplexity"
        ];
        Add = [
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
        Default = "Ecosia Search";
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
      };
    };
    autoConfig = ''
      pref("privacy.resistFingerprinting", false)

      pref("media.hardware-video-decoding.force-enabled", true)
      pref("gfx.x11-egl.force-enabled", true)
      pref("widget.dmabuf.force-enabled", true)
      pref("media.av1.enabled", true);

      pref("browser.tabs.closeWindowWithLastTab", false);
      pref("sidebar.verticalTabs", true);
      pref("ui.systemUsesDarkTheme", 1);
      pref("browser.toolbars.bookmarks.visibility", "never");

      pref("layout.spellcheckDefault", 1);

      pref("widget.use-xdg-desktop-portal.file-picker", 1);

      pref("media.webrtc.camera.allow-pipewire", true);

      pref("browser.discovery.enabled", false);
      pref("app.shield.optoutstudies.enabled", false);
      pref("browser.topsites.contile.enabled", false);
      pref("browser.urlbar.suggest.quicksuggest.sponsored", false);
      pref("browser.urlbar.trending.featureGate", false);
      pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
      pref("browser.newtabpage.activity-stream.feeds.snippets", false);
      pref("browser.newtabpage.activity-stream.section.highlights.includePocket", false);
      pref("browser.newtabpage.activity-stream.section.highlights.includeBookmarks", false);
      pref("browser.newtabpage.activity-stream.section.highlights.includeDownloads", false);
      pref("browser.newtabpage.activity-stream.section.highlights.includeVisited", false);
      pref("browser.newtabpage.activity-stream.showSponsored", false);
      pref("browser.newtabpage.activity-stream.system.showSponsored", false);
      pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);

      pref("browser.link.open_newwindow", 3);
      pref("browser.link.open_newwindow.restriction", 0);
    '';
  };

  environment.systemPackages = lib.mkAfter (with pkgs; [
    home-manager

    gh

    youtube-tui
    impala

    libsecret

    nodejs_24
    mise
    mold
    yarn
    wget

    ffmpeg

    yt-dlp

    # aerc # tui email client
    bluetui

    notesnook # Note taking app

    imv # image viewer
    mpv # video viewer

    obs-studio # video recording

    # web development
    brave

    foot # terminal

    fd # fast directory search
    ripgrep # Easy file content search
    zoxide # smarter cd

    toybox

    sdbus-cpp_2
    sdbus-cpp
    fmt_9

    kdePackages.dolphin

    avfs
    p7zip unzip zip unrar atool

    gcolor3

    bottom # Terminal task manager

    wl-clipboard # Clipboard support for some programs

    playerctl # Media shortcuts

    imagemagickBig # Create, edit, compose, or convert bitmap images

    cliphist # Wayland clipboard manager

    hyprpicker # color picker

    python3
    python313Packages.pygobject3
    gtk3

    sassc
    gnumake
    gnused
    glib.dev
    sbclPackages.cl-cffi-gtk-gdk-pixbuf
    librsvg
    bc

    imagemagick

    socat

    jq

    mesa-demos
  ]);
}
