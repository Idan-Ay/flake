{ pkgs, config, ...}:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;

    opts = {
      # general
      clipboard = "unnamedplus";
      smartindent = true;
      mouse = "a";
      splitright = true;

      # lines
      number = true;
      relativenumber = true;
      cursorline = true;
      signcolumn = "yes";
      scrolloff = 16;
      sidescrolloff = 32;

      # search
      ignorecase = true;
      incsearch = true;
      hlsearch = true;

      # text
      list = true;
      listchars = {
        tab = "→ ";
        trail = "°";
        extends = ">";
        precedes = "<";
      };

      foldermethod = "indent";
      folderlevel = 99;
      foldenable = false;
    };

    plugins = {
      lspconfig.enable = true;
      guess-indent.enable = true;
      cmp.enable = true;
      web-devicons.enable = true;
      nvim-tree.enable = true;
      gitsigns.enable = true;
      lualine.enable = true;
      nvim-autopairs.enable = true;
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>w";
        action = ":w<CR>";
      }
    ];

    colorschemes.nightfox = {
      enable = true;
      settings = {
        groups = {
          all = {
            Normal = {
              bg = "bg1";
            };
          };
        };
        palettes = {
          all = {
            bg1 = "#000000";
          };
        };
      };
    };
  };
}