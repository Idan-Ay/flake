{ pkgs, config, inputs, ... }:

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
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  xdg.dataFile."BlackAndWhite".source = .local/share/themes;

  # xdg.configFile."gtk-3.0/gtk.css".source = ./gtk3.css;
  # xdg.configFile."gtk-4.0/gtk.css".source = ./gtk4.css;

  # xdg.configFile."gtk-4.0/assets" = {
  #   source = ./assets4;
  #   recursive = true;
  # };
}