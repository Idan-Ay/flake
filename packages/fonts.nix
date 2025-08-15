{ pkgs, lib, ... }:

{
  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono   # pick this OR jetbrains-mono (not both)
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