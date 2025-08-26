{ config, pkgs, lib, inputs, ... }:

{
  programs.git.enable = true; # Git

  # enable nix-index auto integration with fish
  programs.command-not-found.enable = true;

  services.gvfs.enable = true;

  services.timesyncd.enable = true;

  services.gnome.gnome-keyring.enable = false;

  nixpkgs.overlays = [
    (final: prev:
      let
        # <<< CHANGE THESE TWO >>>
        rcloneRev = "sha256:9379a2b19c08046080a8a850bbce5af04c922c897cb5e5ba1c9b1f50d59d04ff";   # e.g. from the issue comment you saw
        rcloneSrc = prev.fetchFromGitHub {
          owner = "rclone";
          repo  = "rclone";
          rev   = rcloneRev;
          # temporary fake hash; build once to get the real one and replace it
          hash  = lib.fakeHash;
        };
      in {
        rclone = prev.rclone.overrideAttrs (old: {
          pname = "rclone";
          version = "1.71.0-dev-${rcloneRev}";
          src = rcloneSrc;

          # Go modules vendor hash – set fake first, build will tell you the real one
          vendorHash = lib.fakeHash;

          # Make sure we keep the same build style as nixpkgs (static-ish build)
          CGO_ENABLED = 0;
        });
      }
    )
  ];

  environment.systemPackages = lib.mkAfter (with pkgs; [
    home-manager

    foot # terminal

    fd # fast directory search
    ripgrep # Easy file content search
    zoxide # smarter cd

    fastfetch # View system information

    lf # file manager
    avfs # archive-as-directories
    p7zip unzip zip unrar atool

    xfce.thunar # gui file manager
    xfce.thunar-archive-plugin  # lets Thunar open/extract zip/tar/etc.
    xarchiver

    micro # Code editor

    bottom # Task manager

    wl-clipboard # Clipboard support for some programs

    playerctl # Media shortcuts

    rclone
  ]);
}
