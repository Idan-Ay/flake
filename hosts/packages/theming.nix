{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    capitaine-cursors
  ];

  environment.variables = {
    XCURSOR_THEME = "capitaine-cursors";
    XCURSOR_SIZE = "24";
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
