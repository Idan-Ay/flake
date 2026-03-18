{ pkgs }:

pkgs.appimageTools.wrapType2 rec {
  pname = "jammer";
  version = "3.52";  # bump when you update

  src = pkgs.fetchurl {
    url = "https://github.com/jooapa/jammer/releases/download/${version}/jammer-${version}-x86_64.AppImage";
    hash = "sha256:cbc75ae281a3f66af8ce5b0f28a3919dae3158563b355175a766aba60ad07788";
  };

  extraPkgs = pkgs: with pkgs; [
    icu
  ];
}
