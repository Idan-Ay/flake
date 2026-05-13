{ pkgs, lib, ... }:

{
  programs.git.enable = true;
  security.rtkit.enable = true;

  programs.java = {
    enable = true;
    package = pkgs.javaPackages.compiler.temurin-bin.jre-25;
  };

  virtualisation.docker.enable = true;

  virtualisation.virtualbox = {
    guest.enable = true;
    host.enable = true;
  };

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

  environment.systemPackages = lib.mkAfter (with pkgs; [
    home-manager

    gh

    libsecret

    nodejs_24
    mise
    mold
    yarn
    wget

    ffmpeg

    yt-dlp

    # aerc # tui email client

    notesnook # Note taking app

    discord

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

    socat

    jq

    mesa-demos
  ]);
}
