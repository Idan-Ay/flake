# Rubuild Helper
set -gx FLAKES ~/flake
set -gx SYSTEM_ID (whoami)"@"(hostname)
alias rebuild="nixos-rebuild switch --flake $FLAKES#$SYSTEM_ID"
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

function rm-old-generations
    sudo nix-env --delete-generations old --profile /nix/var/nix/profiles/system
    sudo nix-collect-garbage -d
    sudo /nix/var/nix/profiles/system/bin/switch-to-configuration boot
end