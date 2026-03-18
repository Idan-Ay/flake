{ pkgs, lib, ... }:

{
  programs.git.enable = true;

  services.gvfs.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        FastConnectable = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };

  security.rtkit.enable = true;

  networking.networkmanager.enable = true;

  services.udisks2.enable = true;

  services.ollama = {
    enable = true;
    package = pkgs.ollama-vulkan;
  };

  programs.nix-ld.enable = true;

  programs.java.enable = true;
  virtualisation.docker.enable = true;

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

  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  environment.systemPackages = lib.mkAfter (with pkgs; [
    home-manager

    gh

    nodejs_24
    mise
    mold
    yarn
    wget

    yt-dlp

    hydroxide

    aerc # tui email client

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

    walker # launcher

    fastfetch # View system information

    lf # file manager
    avfs
    p7zip unzip zip unrar atool

    pcmanfm # gui file manager

    bottom # Terminal task manager

    wl-clipboard # Clipboard support for some programs

    playerctl # Media shortcuts

    imagemagickBig # Create, edit, compose, or convert bitmap images

    glib # C library of programming buildings blocks

    cliphist # Wayland clipboard manager

    hyprpicker # color picker

    python3

    jq

    mesa-demos
  ]);
}
