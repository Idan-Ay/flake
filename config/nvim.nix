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
      tabstop = 2;

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

      foldmethod = "indent";
      foldlevel = 99;
      foldenable = false;
    };

    plugins = {
      lsp = {
        enable = true;
        servers = {
          vue_ls.enable = true;
          ts_ls.enable = true;
          cssls.enable = true;
          jsonls.enable = true;
          lua_ls.enable = true;
          qmlls.enable = true;
          nixd.enable = true;
        };
      };
      telescope = {
        enable = true;
        extensions."fzf-native" = {
          enable = true;
          settings = {
            fuzzy = true;
            override_file_sorter = true;
            override_generic_sorter = true;
            case_mode = "smart_case";
          };
        };
        settings = {
          layout = {
            layout_config = { prompt_position = "top"; };
            sorting_strategy = "ascending";
          };
          picker.find_files.hidden = true; # show dotfiles
        };
      };
      guess-indent.enable = true;
      cmp = {
        enable = true;
        autoEnableSources = true;
        autoSelect = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
            { name = "luasnip"; }
          ];
          completion = {
            completeopt = "menu,menuone";
          };
          mapping = {
            "<C-c>" = "cmp.mapping.close()";
            "<Tab>" = "cmp.mapping.confirm({ select = true })";
            "<C-k>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
            "<C-j>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
          };
        };
      };
      luasnip.enable = true;
      friendly-snippets.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp-path.enable = true;
      cmp-buffer.enable = true;

      web-devicons.enable = true;
      nvim-tree.enable = true;
      gitsigns.enable = true;
      lazygit.enable = true;
      lualine = {
        enable = true;
        settings = {
          options = {
            section_separators = { left = ""; right = ""; };
            component_separators  = { left = "|"; right = ""; };
          };
          sections = {
            lualine_a = ["mode"];
            lualine_b = ["branch" "diff" "diagnostics"];
            lualine_c = ["filename"];
            lualine_x = ["filetype"];
            lualine_y = ["progress"];
            lualine_z = ["location"];
          };
        };
      };
      nvim-autopairs.enable = true;
      barbar.enable = true;
      indent-blankline = {
        enable = true;
        settings.indent = {
          char = "│";
          tab_char = "│";
        };
      };
      mini-indentscope = {
        enable = true;
        draw.delay = 0;
        settings = {
          symbol = "│";
          options = { try_as_border = true; };

          indent = {
            scope = { enabled = false; };
          };
        };
      };
    };

    globals.mapleader = " ";

    keymaps = [
      {
        mode = "n";
        key = "w";
        action = ":w<CR>";
      }
      {
        mode = "n";
        key = "<leader>q";
        action = ":q<CR>";
      }
      {
        mode = ["n" "v"];
        key = ";";
        action = ":normal gcc<CR>";
      }
      {
        mode = "n";
        key = "f";
        action = "<cmd>Telescope find_files<CR>";
      }
      {
        mode = "n";
        key = "t";
        action = "<cmd>NvimTreeToggle<CR>";
      }

      # Window navigation
      {
        mode = "n";
        key = "<C-h>";
        action = ":wincmd h<CR>";
      }
      {
        mode = "n";
        key = "<C-j>";
        action = ":wincmd j<CR>";
      }
      {
        mode = "n";
        key = "<C-k>";
        action = ":wincmd k<CR>";
      }
      {
        mode = "n";
        key = "<C-l>";
        action = ":wincmd l<CR>";
      }

      {
        mode = "n";
        key = "<leader>v";
        action = ":vsplit<CR>";
      }
      {
        mode = "n";
        key = "<leader>h";
        action = ":split<CR>";
      }

      #Buffer nav

      {
        mode = "n";
        key = "n";
        action = ":BufferPrevious<CR>";
      }
      {
        mode = "n";
        key = "m";
        action = ":BufferNext<CR>";
      }
      {
        mode = "n";
        key = "N";
        action = ":BufferMovePrevious<CR>";
      }
      {
        mode = "n";
        key = "M";
        action = ":BufferMoveNext<CR>";
      }
      {
        mode = "n";
        key = "<leader>p";
        action = ":BufferPin<CR>";
      }
      {
        mode = "n";
        key = "<leader>c";
        action = ":BufferClose<CR>";
      }
      {
        mode = "n";
        key = "<leader>r";
        action = ":BufferRestore<CR>";
      }

      #LSP
      {
        mode = "n";
        key = "gd";
        action = "<cmd>lua vim.lsp.buf.definition()<CR>";
      }
      {
        mode = "n";
        key = "gr";
        action = "<cmd>lua vim.lsp.buf.reference()<CR>";
      }
      {
        mode = "n";
        key = "K";
        action = "<cmd>lua vim.lsp.buf.hover()<CR>";
      }
      {
        mode = "n";
        key = "<leader>rn";
        action = "<cmd>lua vim.lsp.buf.rename()<CR>";
      }

      # Gitsigns
      {
        mode = "n";
        key = ",g";
        action = "<cmd>lua require('gitsigns').preview_hunk()<CR>";
      }

      # Lazygit
      {
        mode = "n";
        key = "|";
        action = "<cmd>LazyGit<CR>";
      }
    ];

    colorschemes.nightfox = {
      enable = true;
      flavor = "carbonfox";
      settings = {
        groups = {
          all = {
            Normal.bg = "bg0";
            NormalNC.bg = "bg0";
            CursorLineNr.fg = "fg0";
            MiniIndentscopeSymbol.fg = "fg0";
            NormalFloat.bg = "bg0";
            FloatBorder = { fg = "fg0"; bg = "bg0"; };
          };
        };
        palettes = {
          all = {
            bg0 = "#030303";
            fg0 = "#ffffff";
          };
        };
      };
    };
  };
}
