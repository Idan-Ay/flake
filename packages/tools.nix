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

    nodejs_24

    notesnook # Note taking app

    imv # image viewer

    obs-studio # video recording

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
