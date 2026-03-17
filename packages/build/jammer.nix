{ pkgs, ... }: let
  pname = "tuisic";
  version = "2.0.0";

  src = pkgs.fetchurl {
    url = "https://github.com/Dark-Kernel/tuisic/releases/download/v2.0.0/tuisic-linux-x64";
    hash = "sha256:a792eec6e5f4a58f2ff10efb9a390fddaff52a22b6e016b7c471628e18995d00";
  };
in pkgs.stdenv.mkDerivation {
  inherit pname version src;

  name = "${pname}-${version}";   # ← fixed the space in your original

  nativeBuildInputs = [ pkgs.makeWrapper ];   # for wrapProgram

  buildInputs = [ pkgs.sdbus-cpp_2 pkgs.mpv pkgs.fmt_9 ];

  phases = [ "installPhase" ];
  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    install -m755 $src $out/bin/${pname}

    # Wrap the binary so it can find the sdbus-cpp library
    wrapProgram $out/bin/${pname} \
      --prefix LD_LIBRARY_PATH : "${pkgs.lib.makeLibraryPath [ pkgs.sdbus-cpp_2 pkgs.mpv pkgs.fmt_9 ]}"
  '';
}
