{
  description = "Idan's NixOS flake with system-wide packages and user config via Home Manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    home-manager.url = "github:nix-community/home-manager";

    caelestia-shell = {
	    url = "github:Idan-Ay/caelestia-shell-nixos";
	    inputs.nixpkgs.follows = "nixpkgs";
	};
  };

  outputs = { self, nixpkgs, flake-utils, home-manager, caelestia-shell, ... } @ inputs: {

    nixosConfigurations.idan-pc-l = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        home-manager.nixosModules.home-manager
        caelestia-shell.nixosModules.default
        ./system.nix
        {
       	 services.caelestia-shell.enable = true;

		 services.caelestia-shell.config = {
		   bar.workspaces.shown = 7;
		   dashboard.weatherLocation = "40.7128,-74.0060"; # NYC coordinates
		 };
       	  
          home-manager.users.idan = import ./home.nix;
          
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = false;
        }
      ];
    };
  };
}
