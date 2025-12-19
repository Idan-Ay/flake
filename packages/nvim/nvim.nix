{ config, lib, pkgs, ...}:

let
  pluginPath = import ./plugins.nix { inherit pkgs lib inputs; };
  runtimePath = import ./runtime.nix { inherit pkgs; };

  treesitterPath = pkgs.symlinkJoin {
    name = "lazyvim-nix-treesitter-parsers";
    paths = pkgs.vimPlugins.nvim-treesitter.withAllGrammars.dependencies;
  };

  neovimNightly = inputs.neovim-nightly.packages.${system}.default;

  neovimWrapped = pkgs.wrapNeovim neovimNightly {
    configure = {
      customRC = /* vim */ ''
        " Populate paths to neovim
        let g:config_path = "${./config}"
        let g:plugin_path = "${pluginPath}"
        let g:runtime_path = "${runtimePath}"
        let g:treesitter_path = "${treesitterPath}"
        " Begin initialization
        source ${./config/init.lua}
      '';
      packages.all.start = [ pkgs.vimPlugins.lazy-nvim ];
    };
  };
in
{
  packages = rec {
    # Wrap neovim again to make runtime dependencies available
    nvim = pkgs.writeShellApplication {
      name = "nvim";
      runtimeInputs = [ runtimePath ];
      text = ''${neovimWrapped}/bin/nvim "$@"'';
    };
    default = nvim;
  };
}