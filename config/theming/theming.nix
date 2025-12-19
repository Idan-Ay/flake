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
    theme = {
      name = "Blackout";
      package = pkgs.stdenv.mkDerivation {
        pname = "blackout";
        version = "1.0";
        src = ./Blackout;
        installPhase = "mkdir -p $out/share/themes/Blackout; cp -r . $out/share/themes/Blackout";
      };
    };
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

  # xdg.configFile."gtk-4.0/assets" = {
  #   source = ./assets4;
  #   recursive = true;
  # };
}