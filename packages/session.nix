{ pkgs, lib, quickshell, ... }:

{
  programs.nix-ld.enable = true;
  # Enable Niri (Wayland window manager)
  programs.niri.enable = true;

  programs.gamemode.enable = true;

  services = {
    displayManager.enable = true;
    displayManager.ly.enable = true;
  };

  environment.systemPackages = lib.mkAfter (with pkgs; [
    xwayland-satellite

    # waybar # Bar
    quickshell.packages.${system}.default
  ]);

  services.getty.autologinUser = "idan";
}
