{ pkgs, lib, ... }:

{
  programs.git.enable = true;
  security.rtkit.enable = true;

  services.ollama = {
    enable = true;
    package = pkgs.ollama-vulkan;
  };

  programs.java = {
    enable = true;
    package = pkgs.javaPackages.compiler.temurin-bin.jre-25;
  };

  virtualisation.docker.enable = true;

  programs.gamemode.enable = true;

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
      themix-gui = prev.themix-gui.overrideAttrs (old: {
        src = prev.fetchFromGitHub {
          owner = "themix-project";
          repo = "oomox";
          rev = "master";
          sha256 = "sha256-fIBV1fDZyd2u1e9TscRwCIpo89BNeUNWiiXdniF0P7A=";
          fetchSubmodules = true;
        };
        nativeBuildInputs = old.nativeBuildInputs or [] ++ [ prev.python3 prev.which ];

        # If python3 is needed at runtime, also add to buildInputs
        buildInputs = old.buildInputs or [] ++ [ prev.python3 ];
      });
    })
  ];

  environment.systemPackages = lib.mkAfter (with pkgs; [
    home-manager

    gh

    nodejs_24
    mise
    mold
    yarn
    wget

    yt-dlp

    themix-gui

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

    fastfetch # View system information

    lf # file manager
    avfs
    p7zip unzip zip unrar atool

    pcmanfm # gui file manager

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

    jq

    mesa-demos
  ]);
}
