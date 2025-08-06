{
  description = "Idan's NixOS flake with system-wide packages and user config via Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager";

    caelestia-cli.url = "github:t7h-dots/cli";
  };

  outputs = { self, nixpkgs, flake-utils, home-manager, ... }: {

    nixosConfigurations.idan-pc-l = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./system.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = false;
        }
      ];
    };
  };
}