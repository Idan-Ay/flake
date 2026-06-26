{ pkgsLatest-arm, lib, niri, ... }:

{
  services.flatpak = {
    enable = true;
    packages = [
      "io.github.milkshiift.GoofCord"

      # Games
      "org.taisei_project.Taisei"
      "uk.co.powdertoy.tpt"
      "org.supertuxproject.SuperTux"
      "net.supertuxkart.SuperTuxKart"
    ];
  };

  environment.systemPackages = lib.mkAfter (with pkgsLatest-arm; [
    swayidle
    vicinae
    brightnessctl

    obs-studio

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

    # Games
    prismlauncher

    rpi-imager

    anki

    signal-desktop
  ]);
}
