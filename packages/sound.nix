{ config, pkgs, lib, ... }:

{
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  environment.systemPackages = lib.mkAfter ([pkgs.pavucontrol]);
}