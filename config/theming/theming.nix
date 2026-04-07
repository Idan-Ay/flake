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

  qt = {
    enable = true;

    platformTheme.name = "qtct";

    style.name = "kvantum";
  };

  xdg.enable = true;

  xdg.configFile."Kvantum" = {
    source = ./qt;
    recursive = true;
  };

  xdg.configFile."gtk-4.0/assets" = {
    source = ./assets;
    recursive = true;
  };
}
