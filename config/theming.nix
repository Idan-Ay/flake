{ pkgs, config, ... }:
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
      name = "Orchis-Dark";
      package = pkgs.orchis-theme;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  # Live-editable CSS (recommended)
  xdg.configFile."gtk-3.0/gtk.css".text = ''
    window, .background, .csd,    popover, menu, .menu, .popover {
      background-color: rgba(30, 30, 30, 0.85);
    }
  '';
  xdg.configFile."gtk-4.0/gtk.css".text = ''
    window, .background, .csd,    popover, menu, .menu, .popover {
      background-color: rgba(30, 30, 30, 0.85);
    }
  '';
}