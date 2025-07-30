{ config, pkgs, lib, ... }:

{
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    wireplumber.enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  environment.systemPackages =  lib.mkAfter [ (with pkgs; [
    cava
    aubio
  ])];
}