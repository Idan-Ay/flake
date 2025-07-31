{
  description = "Idan's NixOS flake with system-wide packages and user config via Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager";

    caelestia-shell.url = "path:./caelestia-shell";
    caelestia-shell.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, flake-utils, home-manager, caelestia-shell, ... }: {

    nixosConfigurations.idan-pc-l = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./system.nix
        home-manager.nixosModules.home-manager
        caelestia-shell.nixosModules.default

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = false;

          services.caelestia-shell.enable = true;
          services.caelestia-shell.config = {
            bar.workspaces.shown = 4;
            dashboard.weatherLocation = "50.9289883,6.3601925";
          };
        }
      ];
    };
  };
}