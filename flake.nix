{
  description = "Idan's NixOS flake with system-wide packages and user config via Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
  };

  outputs = { self, nixpkgs, flake-utils, home-manager, ... } @ inputs: {

    nixosConfigurations.idan-pc-l = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        home-manager.nixosModules.home-manager
        ./system.nix
        {
          home-manager.users.idan = import ./home.nix;
          
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = false;
        }
      ];
    };
  };
}
