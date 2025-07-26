{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    orchis-theme
    papirus-nord
    arc-icon-theme
  ];

  environment.variables = {
    GTK_THEME = "Orchis-Red-Dark";
    XCURSOR_THEME = "Arc-Dark";
    XCURSOR_SIZE = "24";
    ICON_THEME = "Papirus-Nord";
  };

  fonts = {
    packages = with pkgs; [
      twemoji-color-font
    ];
    fontconfig.defaultFonts = {
      emoji = [ "Twemoji Mozilla" ];
    };
  };
}
