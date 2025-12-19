{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs-latest.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/release-25.05";

    vicinae.url = "github:vicinaehq/vicinae"; 

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell?ref=a5431dd02dc23d9ef1680e67777fed00fe5f7cda";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly.url = "github:neovim/neovim?dir=contrib";
    neovim-nightly.inputs.nixpkgs.follows = "nixpkgs";

    huez-nvim = { url = "github:vague2k/huez.nvim"; flake = false; };
    blame-me-nvim = { url = "github:hougesen/blame-me.nvim"; flake = false; };
    cmake-tools-nvim = { url = "github:Civitasv/cmake-tools.nvim"; flake = false; };
    cmake-gtest-nvim = { url = "github:hfn92/cmake-gtest.nvim"; flake = false; };
  };

  outputs = { 
    self,
    nixpkgs,
    nixpkgs-latest,
    flake-utils,
    home-manager,
    quickshell,
    vicinae,
    lazyvim,
    neovim-nightly,
    huez-nvim,
    blame-me-nvim,
    cmake-tools-nvim,
    cmake-gtest-nvim,
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
        modules = [ ./home.nix vicinae.homeManagerModules.default lazyvim.homeManagerModules.default ];
        extraSpecialArgs = { inherit inputs; };
      };
    };
}
