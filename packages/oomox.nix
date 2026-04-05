{pkgs, lib, python3, ...}:
let
  py = python3.withPackages (p: [
    p.pygobject3
  ]);
in
pkgs.stdenv.mkDerivation {
  pname = "oomox";
		src = pkgs.fetchFromGitHub {
    owner = "themix-project";
				repo = "oomox";
				rev = "master";
				# fetchSubmodules = true;
		};

  nativeBuildInputs = [
    pkgs.gobject-introspection
    # pkgs.python3
				py
    pkgs.sassc
    pkgs.wrapGAppsHook3
  ];

  buildInputs = [
    pkgs.gdk-pixbuf
    pkgs.glib
    pkgs.gtk3
    pkgs.librsvg
    py
  ];

		postPatch = ''
    substituteInPlace gui.sh packaging/bin/{oomox,themix}-gui --replace python3 ${lib.getExe py}
  '';

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    make DESTDIR=/ APPDIR=$out/opt/oomox PREFIX=$out install_gui install_import_xresources install_export_xresources
    python -O -m compileall $out/opt/oomox/oomox_gui -d /opt/oomox/oomox_gui

    runHook postInstall
  '';
}
