{user, pkgs, config, lib, ...}:
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

  imports = [
    ./config/theming/theming.nix
    ./config/nvim.nix
    ./config/librewolf.nix
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

  xdg.configFile = {
    "xdg-desktop-portal-termfilechooser/config" =
    {
      force = true;
      text =
      ''
        [filechooser]
        cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
      '';
    };

    "foot/foot.ini".source = ./config/foot.ini;

    "wallpapers" = {
      source = ./config/wallpapers;
      recursive = true;
    };

    "hypr".source = ./config/hypr;

    "niri/config.kdl".source = ./config/niri.kdl;

    "quickshell" = {
      source = ./config/quickshell;
      recursive = true;
    };

    "vicinae/settings.json".source = ./config/vicinae/settings.jsonc;

    "imv/config".text = "[options]\nbackground = 010101";

    "youtube-tui" = {
      source = ./config/youtube-tui;
      recursive = true;
    };

    "rmpc" = {
      source = ./config/rmpc;
      recursive = true;
    };

    "joplin" = {
      source = ./config/joplin;
      recursive = true;
    };
  };

  home.file.".local/share/vicinae/themes/blackTheme.toml".source = ./config/vicinae/blackTheme.toml;
}
