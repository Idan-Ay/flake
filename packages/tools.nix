{ pkgs, lib, ... }:

{
  programs.git.enable = true;

  # enable nix-index auto integration with fish
  programs.command-not-found.enable = true;

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

  networking.networkmanager.enable = true;

  services.udisks2.enable = true;

  services.ollama = {
    enable = true;
    package = pkgs.ollama-vulkan;
    loadModels = [
      "drivedenpadev/deepseek-v3.2"
    ];
  };

  programs.nix-ld.enable = true;

  programs.java.enable = true;

  environment.systemPackages = lib.mkAfter (with pkgs; [
    home-manager

    gh

    notesnook # Note taking app

    # web development
    firefox-devedition
    ungoogled-chromium

    foot # terminal

    fd # fast directory search
    ripgrep # Easy file content search
    zoxide # smarter cd

    toybox

    walker # launcher

    fastfetch # View system information

    lf # file manager
    avfs # archive-as-directories
    p7zip unzip zip unrar atool

    # xfce.thunar # Xfce file manager
    # xfce.thunar-volman # Thunar extension for automatic management of removable drives and media
    # xfce.thunar-vcs-plugin # Thunar plugin providing support for Subversion and Git
    # xfce.thunar-archive-plugin # Thunar plugin providing file context menus for archives
    # xfce.thunar-media-tags-plugin # Thunar plugin providing tagging and renaming features for media files

    pcmanfm

    bottom # Terminal task manager

    wl-clipboard # Clipboard support for some programs

    playerctl # Media shortcuts

    imagemagickBig # Create, edit, compose, or convert bitmap images

    glib # C library of programming buildings blocks

    cliphist # Wayland clipboard manager

    eyedropper # color picker

    python3

    jq

    mesa-demos
  ]);
}
