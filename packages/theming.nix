{ config, pkgs, lib, ... }:

{
  environment.systemPackages = lib.mkAfter (with pkgs; [
    capitaine-cursors # Cursor Pack 

    jetbrains-mono
  ]);

  environment.sessionVariables = {
    XCURSOR_THEME = "capitaine-cursors";
    XCURSOR_SIZE = "24";
  };

  fonts = {
    packages = with pkgs; [
      twemoji-color-font
      nerd-fonts.jetbrains-mono
      material-symbols
    ];
    fontconfig.defaultFonts = {
      emoji = [ "Twemoji Mozilla" ];
    };
  };
}
