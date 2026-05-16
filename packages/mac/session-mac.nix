{ pkgs, ... }:

{
  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
  };

  hardware.apple.touchBar = {
    enable = true;
    package = pkgs.tiny-dfr;
  };
}
