{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-latest.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-25.05";

    anyrun = {
      url = "github:anyrun-org/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixpkgs-latest, flake-utils, home-manager, ... } @ inputs:
    let
      system = "x86_64-linux";
      pkgsLatest = import nixpkgs-latest { inherit system; config.allowUnfree = true; };
    in {
      nixosConfigurations.idan-pc-l = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = { inherit inputs pkgsLatest; };

        modules = [
          home-manager.nixosModules.home-manager
          ./system.nix
          {
            home-manager.users.idan = import ./home.nix;
            
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = false;

            home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
      };
    };
}
