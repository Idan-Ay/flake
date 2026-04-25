{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-latest.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-25.11";

    niri.url = "github:niri-wm/niri/wip/branch";

    nixvim.url = "github:nix-community/nixvim";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";

    nextdns.url = "git+ssh://git@github.com/Idan-Ay/nextdns-flake";
  };

  outputs = {
    nixpkgs,
    nixpkgs-latest,
    home-manager,
    niri,
    nextdns,
    nixvim,
    nix-flatpak,
    ...
    } @ inputs:
    let
      pkgsLatest = import nixpkgs-latest { system = "x86_64-linux"; config.allowUnfree = true; };
      user = "idan";
    in {
      nixosConfigurations = {
        pc = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs user pkgsLatest niri; };
          modules = [
            ./system.nix
            nextdns.nixosModules.nextdns
            nix-flatpak.nixosModules.nix-flatpak
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
          extraSpecialArgs = { inherit inputs user pkgsLatest; };
        };
      };
    };
}
