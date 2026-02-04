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

  # xdg.dataFile."themes/blackandwhite" = {
  #   source = builtins.path {
  #     path = ./BlackAndWhite;  # Resolves to an absolute store path
  #     name = "blackandwhite";  # Optional but recommended: unique name for the store path
  #   };
  # };

  xdg.enable = true;

  # xdg.configFile."gtk-3.0/gtk.css".source = ./gtk3.css;
  # xdg.configFile."gtk-4.0/gtk.css".source = ./gtk4.css;

  xdg.configFile."gtk-4.0/assets" = {
    source = ./assets;
    recursive = true;
  };

  qt = {
    enable = true;
    platformTheme = "gnome";
    style.name = "adwaita-highcontrast";
  };

  home.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "gnome";
    QT_STYLE_OVERRIDE = "adwaita-highcontrast";
  };
}
