{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-latest.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-25.11";

    nixos-apple-silicon.url = "github:nix-community/nixos-apple-silicon";

    niri.url = "github:niri-wm/niri";

    nixvim.url = "github:nix-community/nixvim";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.7.0";

    user-chrome = {
      type = "github";
      owner = "Idan-Ay";
      repo = "firefox-contrast";
      ref = "v0.2h";
      flake = false;
    };
  };

  outputs = {
    nixpkgs,
    nixpkgs-latest,
    home-manager,
    niri,
    nixvim,
    nix-flatpak,
    nixos-apple-silicon,
    ...
    } @ inputs:
    let
      pkgsLatest-x86 = import nixpkgs-latest { system = "x86_64-linux"; config.allowUnfree = true; };
      pkgsLatest-arm = import nixpkgs-latest { system = "aarch64-linux"; config.allowUnfree = true; };
      user = "idan";
    in {
      nixosConfigurations = {
        pc = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs user pkgsLatest-x86 niri; };
          modules = [
            ./system-pc.nix
            nix-flatpak.nixosModules.nix-flatpak
          ];
        };
        mac = nixpkgs.lib.nixosSystem {
          system = "aarch64-linux";
          specialArgs = { inherit inputs user pkgsLatest-arm niri; };
          modules = [
            ./system-mac.nix
            nix-flatpak.nixosModules.nix-flatpak
            nixos-apple-silicon.nixosModules.default
          ];
        };
      };

      homeConfigurations = {
        pc = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          modules = [
            ./home.nix
            nixvim.homeModules.default
          ];
          extraSpecialArgs = { inherit inputs user; };
        };
        mac = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.aarch64-linux;
          modules = [
            ./home.nix
            nixvim.homeModules.default
          ];
          extraSpecialArgs = { inherit inputs user; };
        };
      };
    };
}
