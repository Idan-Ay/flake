{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      terminus_font
      nerd-fonts.jetbrains-mono
      twemoji-color-font
      material-symbols
    ];
    fontconfig = {
      defaultFonts = {
        serif = [ "JetBrainsMono Nerd Font" ];
        sansSerif = [ "JetBrainsMono Nerd Font" ];
        monospace = [ "JetBrainsMono Nerd Font" ];
        emoji = [ "Twemoji Mozilla" ];
      };
    };
  };
}
