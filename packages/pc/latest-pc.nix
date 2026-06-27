{ pkgsLatest-x86, lib, pkgs, ... }:

{
  services.ollama = {
    enable = true;
    package = pkgsLatest-x86.ollama-cuda;
  };

  services.flatpak = {
    enable = true;
    packages = [
      "io.github.milkshiift.GoofCord" # free but uses unfree web application
      "com.obsproject.Studio"

      # Games
      "org.taisei_project.Taisei"
      "uk.co.powdertoy.tpt"
      "org.srb2.SRB2"
      "org.supertuxproject.SuperTux"
      "net.supertuxkart.SuperTuxKart"
      "io.github.lavenderdotpet.LibreQuake"

      "app.twintaillauncher.ttl" # free but installs unfree
    ];
  };

  programs.firejail.wrappedBinaries = {
    steam = { # unfree and installs unfree
      executable = "${pkgsLatest-x86.steam}/bin/steam";
      profile = "${pkgs.firejail}/etc/firejail/steam.profile";
      desktop = "${pkgsLatest-x86.steam}/share/applications/steam.desktop";
    };
  };

  environment.systemPackages = lib.mkAfter (with pkgsLatest-x86; [
    vicinae

    ladybird

    rmpc

    blender
    godot
    gimp
    krita
    inkscape
    kdePackages.kdenlive
    audacity
    libreoffice
    focuswriter

    vscodium

    anki

    protonplus

    signal-desktop
  ]);
}
