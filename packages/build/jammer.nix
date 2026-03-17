self: super: {
  jammer = super.appimageTools.wrapType1 {
    name = "jammer";
    # version = "16";

    src = super.fetchurl {
      url = "https://github.com/jooapa/jammer/releases/download/3.52/jammer-3.52-x86_64.AppImage";
      hash = "sha256:cbc75ae281a3f66af8ce5b0f28a3919dae3158563b355175a766aba60ad07788";
    };
  };
}
