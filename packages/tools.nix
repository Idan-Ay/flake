{ config, pkgs, lib, inputs, ... }:

{
  programs.git.enable = true; # Git

  # enable nix-index auto integration with fish
  programs.command-not-found.enable = true;

  services.gvfs.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        FastConnectable = true;
      };
      Policy = {
        AutoEnable = true;
      };
    };
  };

  networking.networkmanager.enable = true;

  services.udisks2.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    configure = {
      customRC = ''

          let mapleader = "\<Space>"

          lua << EOF
            ${builtins.readFile /home/user/.config/nvim/init.lua}

            ${builtins.readFile /home/user/.config/nvim/lua/config/lazy.lua}

            ${builtins.readFile /home/user/.config/nvim/lua/config/keymaps.lua}

            ${builtins.readFile /home/user/.config/nvim/lua/config/autocmds.lua}
          EOF

        '';
    };
  };

  environment.systemPackages = lib.mkAfter (with pkgs; [
    home-manager

    foot # terminal

    fd # fast directory search
    ripgrep # Easy file content search
    zoxide # smarter cd

    fastfetch # View system information

    lf # file manager
    avfs # archive-as-directories
    p7zip unzip zip unrar atool

    nemo # Graphical file manager

    bottom # Terminal task manager
    
    wl-clipboard # Clipboard support for some programs

    playerctl # Media shortcuts

    imagemagickBig # Create, edit, compose, or convert bitmap images

    glib # C library of programming buildings blocks

    cliphist # Wayland clipboard manager

    eyedropper # color picker

    python3
  ]);
}
