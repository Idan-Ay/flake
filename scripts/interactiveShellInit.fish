fish_vi_key_bindings
alias nr="sudo nixos-rebuild switch --flake ~/flake#pc"
alias hr="home-manager switch --flake ~/flake#pc"
alias nu="sudo nixos-rebuild switch --flake ~/flake#pc --upgrade"

function enr;
								vim ~/flake
								sudo nixos-rebuild switch --flake ~/flake#pc
end

function ehr;
								vim ~/flake
								home-manager switch --flake ~/flake#pc
end

function cg;
								sudo nix-collect-garbage -d
								nix-collect-garbage -d
end
