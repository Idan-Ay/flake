{ pkgs, fetchFromGitHub, ... }:
let
  contrastGTK = pkgs.stdenv.mkDerivation {
    pname = "contrast";
    version = "1.0";
    src = ./contrastGTK;

    nativeBuildInputs = [
      pkgs.sassc
      pkgs.gnumake
      pkgs.glib.dev
      pkgs.sbclPackages.cl-cffi-gtk-gdk-pixbuf
      pkgs.librsvg
    ];

    installPhase = ''
      mkdir -p $out/share/themes/contrast
      cp -r $src/* $out/share/themes/contrast/
    '';
  };

  # themix-gui = pkgs.stedev.mkDerivation {
    # src = fetchFromGitHub {
      # owner = "themix-project";
      # repo = "themix-gui";
      # rev = "master";
      # hash = "sha256-BPZzMT1IrZvgva/m5tYMaDYoUaP3VmpmcYeOUOwuoUY=";
      # fetchSubmodules = true;
    # };
    # nativeBuildInputs = [
      # gobject-introspection
      # py
      # sassc
      # wrapGAppsHook3
    # ];

    # buildInputs = [
      # gdk-pixbuf
      # glib
      # gtk3
      # librsvg
      # py
    # ];

  # postPatch = ''
    # substituteInPlace gui.sh packaging/bin/{oomox,themix}-gui --replace python3 ${lib.getExe py}
  # '';

  # dontBuild = true;

  # installPhase = ''
    # runHook preInstall

    # make DESTDIR=/ APPDIR=$out/opt/oomox PREFIX=$out install_gui install_import_xresources install_export_xresources
    # python -O -m compileall $out/opt/oomox/oomox_gui -d /opt/oomox/oomox_gui

    # runHook postInstall
  # '';
  # }
in
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
      name = "Orchis-Grey-Dark";
      package = pkgs.orchis-theme.override {
        tweaks = [ "black" ];
      };
    };
    # theme = {
      # name = "contrast";
      # package = contrastGTK;
    # };
    gtk4.extraCss = builtins.readFile ./gtk4.css;
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };
    gtk3.extraCss = builtins.readFile ./gtk3.css;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
  };

  # xdg.dataFile."themes/contrast" = {
    # source = builtins.path {
      # path = ./contrastGTK;
      # name = "contrast";
    # };
  # };

  xdg.enable = true;

  # xdg.configFile."gtk-3.0/gtk.css".source = ./gtk3.css;
  # xdg.configFile."gtk-4.0/gtk.css".source = ./gtk4.css;

  xdg.configFile."gtk-4.0/assets" = {
    source = ./assets;
    recursive = true;
  };
}
