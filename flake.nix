{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-latest.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-25.11";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nixvim.url = "github:nix-community/nixvim";
  };

  outputs = { 
    nixpkgs,
    nixpkgs-latest,
    home-manager,
    nixvim,
    zen-browser,
    ...
    } @ inputs:
    let
      pkgsLatest = import nixpkgs-latest { system = "x86_64-linux"; config.allowUnfree = true; };
      pkgsLatestMac = import nixpkgs-latest { system = "aarch64-linux"; config.allowUnfree = true; };
    in {
      nixosConfigurations = {
        pc = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs pkgsLatest; };
          modules = [./system-pc.nix];
        };
        mac = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          specialArgs = { inherit inputs pkgsLatestMac; };
          modules = [./system-mac.nix];
        };
      };

      homeConfigurations = {
        pc = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [
            ./home.nix
            nixvim.homeModules.default
            zen-browser.homeModules.default
          ];
          extraSpecialArgs = { inherit inputs; };
        };
        mac = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-linux;
          modules = [
            ./home.nix
            nixvim.homeModules.default
            zen-browser.homeModules.default
          ];
          extraSpecialArgs = { inherit inputs; };
        };
      };
    };
}
