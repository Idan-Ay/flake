{ pkgs, ... }: let
  pname = "jammer";

  src = pkgs.fetchurl {
    url = "https://github.com/jooapa/jammer/releases/download/3.52/jammer-3.52-x86_64.AppImage";
    hash = "sha256:cbc75ae281a3f66af8ce5b0f28a3919dae3158563b355175a766aba60ad07788";
  };
in pkgs.stdenv.mkDerivation {
  inherit pname src;

  name = "${pname}";   # ← fixed the space in your original

  nativeBuildInputs = [ pkgs.makeWrapper ];   # for wrapProgram

  buildInputs = [ pkgs.sdbus-cpp_2 pkgs.mpv pkgs.fmt_9 ];
		# extraPackages = [ pkgs.sdbus-cpp_2 pkgs.mpv pkgs.fmt_9 ];

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
