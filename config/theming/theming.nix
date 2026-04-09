{ pkgs, lib, orchis-kde, ... }:
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
    # style.name = "adwaita-highcontrastinverse";
    # style.name = "kvantum";
  # };

  # qt = {
    # enable = true;

    # platformTheme.name = "qtct";
    # style.name = "kvantum";
  # };

  xdg.configFile = {
    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=BlackGlass
    '';

    "Kvantum/BlackGlass".source = ./BlackGlass;
  };
  # home.file = {
    # ".local/share/aurorae/themes".source = orchis-kde + "/aurorae";
    # ".local/share/color-schemes".source = orchis-kde + "/color-schemes";
    # ".local/share/plasma/look-and-feel".source = orchis-kde + "/plasma/look-and-feel";
  # };

  # xdg.configFile."Kvantum" = {
    # source = ./qt;
    # recursive = true;
  # };

  xdg.enable = true;

}
