{
  programs.home-manager.enable = true;

  home.username = "idan";
  home.homeDirectory = "/home/idan";
  home.stateVersion = "25.05";

  imports = [
    ./config/theming/theming.nix
    ./packages/home/nvim.nix
  ];

  services.vicinae = {
      enable = true;
      autoStart = true;
  };

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
  };
}
