{ pkgs, ... }:
{
  home.pointerCursor = {
    name = "capitaine-cursors";
    package = pkgs.capitaine-cursors;
    size = 32;
    gtk.enable = true;
    x11.enable = true;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Orchis-Grey-Dark";
      package = pkgs.orchis-theme.override {
        tweaks = [ "black" ];
      };
    };
    gtk4.extraCss = builtins.readFile ./gtk4.css;
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk3.extraCss = builtins.readFile ./gtk3.css;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  xdg.configFile."gtk-4.0/assets" = {
    source = ./assets;
    recursive = true;
  };

  # qt = {
    # enable = true;

    # platformTheme.name = "qt5ct";
    # style.name = "kvantum";
  # };

  xdg.configFile = {
    # "Kvantum/kvantum.kvconfig".text = ''
      # [General]
      # theme=Orchis-solidDark
    # '';

    "Kvantum/Orchis-solidDark".source = ./Orchis-kde/Kvantum/;
  };
  home.file.".local/share/" = {
    "aurorae/themes" = ./Orchis-kde/aurorae;
    "color-schemes" = ./Orchis-kde/color-schemes;
    "plasma/desktoptheme/Orchis-dark" = ./Orchis-kde/plasma/desktoptheme/Orchis-dark;
    "plasma/desktoptheme/Orchis-dark/icons" = ./Orchis-kde/plasma/desktoptheme/icons;
    "plasma/desktoptheme/Orchis-dark/colors" = ./Orchis-kde/color-schemes
    "plasma/look-and-feel".source = ./Orchis-kde/plasma/look-and-feel;
  };

  # xdg.configFile."Kvantum" = {
    # source = ./qt;
    # recursive = true;
  # };

  xdg.enable = true;

}
