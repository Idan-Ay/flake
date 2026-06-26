{ pkgsLatest-arm, lib, niri, ... }:

{
  services.flatpak = {
    enable = true;
    packages = [
      "io.github.milkshiift.GoofCord"
      "com.obsproject.Studio"

      # Games
      "org.taisei_project.Taisei"
      "uk.co.powdertoy.tpt"
      "org.prismlauncher.PrismLauncher"
      "org.supertuxproject.SuperTux"
      "net.supertuxkart.SuperTuxKart"
    ];
  };

  environment.systemPackages = lib.mkAfter (with pkgsLatest-arm; [
    swayidle
    vicinae
    brightnessctl

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
    the-powder-toy

    rpi-imager

    anki

    signal-desktop
  ]);
}
