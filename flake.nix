{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-latest.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-25.11";

    vicinae.url = "github:vicinaehq/vicinae"; 

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim.url = "github:nix-community/nixvim";
  };

  outputs = { 
    nixpkgs,
    nixpkgs-latest,
    home-manager,
    quickshell,
    vicinae,
    nixvim,
    ... 
    } @ inputs:
    let
      system = "x86_64-linux";
      pkgsLatest = import nixpkgs-latest { inherit system; config.allowUnfree = true; };
    in {
      nixosConfigurations.idan-pc-l = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs pkgsLatest quickshell; };
        modules = [./system.nix];
      };

      homeConfigurations.idan-pc-l = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          ./home.nix
          vicinae.homeManagerModules.default
          nixvim.homeModules.default
        ];
        extraSpecialArgs = { inherit inputs; };
      };
    };
}
