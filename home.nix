{pkgsLatest, user, pkgs, config, lib, ...}:
{
  programs.home-manager.enable = true;

  home.username = "${user}";
  home.homeDirectory = "/home/${user}";
  home.stateVersion = "25.05";

  programs.git = {
    settings = {
      user.name = "Idan-Ay";
    };
  };

  programs.librewolf = {
    enable = true;
    package = pkgsLatest.librewolf;
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

      "privacy.resistFingerprinting" = true;
      "privacy.resistFingerprinting.pbmode" = true;
    };
  };

  imports = [
    ./config/theming/theming.nix
    ./config/nvim.nix
  ];

  services.syncthing.enable = true;

  services.mpd = {
    enable = true;
    musicDirectory = "${config.home.homeDirectory}/Music";
    extraConfig = ''
      audio_output {
        type "pipewire"
        name " music player"
      }
    '';
  };

  home.packages = with pkgs; [
    mpc
  ];

  xdg.configFile."xdg-desktop-portal-termfilechooser/config" =
  {
    force = true;
    text =
    ''
      [filechooser]
      cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
    '';
  };

  xdg.configFile = {
    "foot/foot.ini".source = ./config/foot.ini;

    "wallpapers" = {
      source = ./config/wallpapers;
      recursive = true;
    };

    "niri/config.kdl".source = ./config/niri.kdl;

    "quickshell" = {
      source = ./config/quickshell;
      recursive = true;
    };

    "vicinae/vicinae.json".source = ./config/vicinae/vicinae.json;

    "fastfetch" = {
      source = ./config/fastfetch;
      recursive = true;
    };

    "imv/config".text = "[options]\nbackground = 010101";

    "youtube-tui" = {
      source = ./config/youtube-tui;
      recursive = true;
    };

    "rmpc" = {
      source = ./config/rmpc;
      recursive = true;
    };

    "qutebrowser" = {
      source = ./config/qutebrowser;
      recursive = true;
    };
  };

  home.file.".local/share/vicinae/themes/blackTheme.toml".source = ./config/vicinae/blackTheme.toml;
}
