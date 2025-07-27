{
  description = "Idan's NixOS flake with system-wide packages and user config via Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager";

    caelestia-shell.url = "github:caelestia-dots/shell-nixos";
  };

  outputs = { self, nixpkgs, flake-utils, home-manager, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in {
        nixosConfigurations.idan-pc-l = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          modules = [
            ./hosts/idan-pc-l.nix
            home-manager.nixosModules.home-manager

            # Include the caelestia-shell module
            caelestia-shell.nixosModules.default

            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = false;

              users.users.idan = {
                isNormalUser = true;
                extraGroups = [ "wheel" "networkmanager" "video" ];
                shell = pkgs.fish;
              };

              home-manager.users.idan = import ./home/idan.nix;
            }
          ];
        };
      });
}