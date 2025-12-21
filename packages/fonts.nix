{ pkgs, lib, ... }:

{
  fonts = {
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      twemoji-color-font
      material-symbols
    ];
    fontconfig = {
      defaultFonts = {
        monospace = [ "JetBrainsMono Nerd Font" ];
        emoji = [ "Twemoji Mozilla" ];
      };
    };
  };
}
