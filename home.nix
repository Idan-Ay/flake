{
  programs.home-manager.enable = true;

  home.username = "idan";
  home.homeDirectory = "/home/idan";
  home.stateVersion = "25.05";

  programs.git = {
    settings = {
      user.name = "Idan-Ay";
    };
  };

  imports = [
    ./config/theming/theming.nix
    ./config/nvim.nix
  ];

  services.syncthing.enable = true;

  programs.zen-browser.enable = true;

  xdg.configFile = { 
    "foot/foot.ini".source = ./config/foot.ini;

    "lf/lfrc".source = ./config/lfrc;

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
  };

  home.file.".local/share/vicinae/themes/blackTheme.toml".source = ./config/vicinae/blackTheme.toml;
}
