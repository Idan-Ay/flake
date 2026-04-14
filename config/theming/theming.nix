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

  xdg.configFile."gtk-4.0/assets".source = ./assets;

  qt = {
    enable = true;
    kde.settings.kdeglobals.General.TerminalApplication = "foot";
    kde.settings.kdeglobals.General.ColorScheme = "BlackGlass";
    kde.settings.dolphinrc.General.ColorScheme = "BlackGlass";
    kde.settings.arkrc.General.ColorScheme = "BlackGlass";
  };

  xdg.configFile = {
    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=BlackGlass
    '';

    "Kvantum/BlackGlass".source = ./kvantum;
  };
  home.file = {
    ".local/share/color-schemes/BlackGlass.colors".source = ./color-scheme.colors;
    # ".local/share/aurorae/themes/BlackGlass".source = ./aurorae;
    # ".local/share/plasma/desktoptheme/BlackGlass".source = ./desktoptheme;
    # ".local/share/plasma/look-and-feel/BlackGlass".source = ./look-and-feel;
  };
}
