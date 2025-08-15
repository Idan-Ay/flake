{ config, ... }:

{
  programs.fish = {
    shellInit = ''
      set -gx FLAKES /home/idan/flakes
      set -gx SYSTEM_ID (whoami)"@"(hostname)
      alias rebuild="sudo nixos-rebuild switch --flake $FLAKES#$SYSTEM_ID"
      alias update="nix flake update $FLAKES && rebuild"

      function flake-push
        set msg (string join " " $argv)
        if test -z "$msg"
          echo "No commit message, use \"flake-push <your message>"\"
          return 1
        end
        git -C $FLAKES add .
        git -C $FLAKES commit -m "$msg"
        git -C $FLAKES push
      end
    '';
  };
}