{ pkgs, config, ... }:
{
  gtk = {
    enable = true;
    theme = {
      name = "adw-gtk3";         # solid baseline
      package = pkgs.adw-gtk3;
    };
    # Cursor/icons optional…
  };

  # Live-editable CSS (recommended)
  xdg.configFile."gtk-3.0/gtk.css".text = ''
    /* Make CSD windows translucent so Hyprland blur is visible */
    window, .background, .csd {
      background-color: transparent;
    }
    /* Optional: slightly opaque popovers/menus so text stays readable */
    popover, menu, .menu, .popover {
      background-color: rgba(30, 30, 32, 0.85);
    }
  '';

  xdg.configFile."gtk-4.0/gtk.css".text = ''
    window, .background, .csd {
      background-color: transparent;
    }
    popover, menu, .menu, .popover {
      background-color: rgba(30, 30, 32, 0.85);
    }
  '';
}