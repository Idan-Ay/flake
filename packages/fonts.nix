{ pkgs, ... }:

let
  anurati = pkgs.stdenvNoCC.mkDerivation {
    pname = "anurati";
    version = "1.0";  # Arbitrary version

    src = ./fonts/anurati.otf;  # Path to your font file(s)/directory

    # No need for unpackPhase if src is a directory of files
    dontUnpack = true;

    installPhase = ''
      mkdir -p $out/share/fonts/opentype  # Or /opentype for .otf files
      cp $src $out/share/fonts/opentype/anurati.otf  # Adjust if needed
    '';

    meta = {
      description = "anurati";
      platforms = pkgs.lib.platforms.all;
    };
  };
in
{
  fonts = {
    packages = with pkgs; [
      terminus_font
      nerd-fonts.jetbrains-mono
      twemoji-color-font
      material-symbols
      anurati
    ];
    fontconfig = {
      defaultFonts = {
        serif = [ "JetBrainsMono Nerd Font" ];
        # sansSerif = [ "JetBrainsMono Nerd Font" ];
        monospace = [ "JetBrainsMono Nerd Font" ];
        emoji = [ "Twemoji Mozilla" ];
      };
    };
  };
}
