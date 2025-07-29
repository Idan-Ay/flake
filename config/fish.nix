programs.fish = {
  enable = true;

  shellInit = ''
    set -gx FLAKE ~/flakes
    set -gx SYSTEM_ID (whoami)"@"(hostname)
    alias rebuild="sudo nixos-rebuild switch --flake $FLAKE#$SYSTEM_ID"
    alias update="nix flake update $FLAKE && rebuild"
  '';
}