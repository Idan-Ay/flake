{ pkgs, lib, ... }:

{
  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      twemoji-color-font
      material-symbols
    ];
    fontconfig = {
      # Make Nerd Font the default monospace so terminals/editors pick it
      defaultFonts = {
        monospace = [ "JetBrainsMono Nerd Font" ];
        emoji = [ "Twemoji Mozilla" ];
      };
    };
  };
}