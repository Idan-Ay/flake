{ pkgs, lib, ... }:

{
  programs.git.enable = true;
  security.rtkit.enable = true;

  programs.java = {
    enable = true;
    package = pkgs.javaPackages.compiler.temurin-bin.jre-25;
  };

  virtualisation.docker.enable = true;

  programs.gamemode.enable = true;

  programs.noisetorch.enable = true;

  nixpkgs.overlays = [
    (final: prev: {
      yt-dlp = prev.yt-dlp.overrideAttrs (old: {
        src = prev.fetchFromGitHub {
          owner = "yt-dlp";
          repo = "yt-dlp";
          rev = "master";
          hash = "sha256-BPZzMT1IrZvgva/m5tYMaDYoUaP3VmpmcYeOUOwuoUY=";
        };
      });
      joplin-cli = prev.joplin-cli.overrideAttrs (old: {
        installPhase = ''
          runHook preInstall

          # Remove dev dependencies
          yarn workspaces focus --production root joplin

          mkdir -p $out/lib/packages
          mkdir $out/bin
          mv packages/{app-cli,renderer,tools,utils,lib,htmlpack,turndown{,-plugin-gfm},fork-*} $out/lib/packages/
          rm -rf $out/lib/packages/lib/node_modules/canvas

          # Remove extra files
          rm -rf $out/lib/packages/app-cli/{app/*.test.ts,*.md,.*ignore,tests/,tools/,*.js,tsconfig.json,*.sh}
          mv $out/lib/packages/app-cli/package.json $out/lib/packages/app-cli/app

          # Link final binary
          chmod +x $out/lib/packages/app-cli/app/main.js
          ln -s $out/lib/packages/app-cli/app/main.js $out/bin/joplin
          patchShebangs $out/bin/joplin

          runHook postInstall
        '';
      });
    })
  ];

  programs.yazi = {
    enable = true;
    package = (pkgs.yazi.override {
      _7zz = pkgs._7zz-rar;  # Support for RAR extraction
    });
    plugins = {
      inherit (pkgs.yaziPlugins) wl-clipboard;
    };
    settings = {
      keymap = lib.importTOML ../config/yazi/keymap.toml;
      theme = lib.importTOML ../config/yazi/theme.toml;
    };
  };

  programs.localsend = {
    enable = true;
    openFirewall = true;
  };

  programs.firejail = {
    enable = true;
    wrappedBinaries = {
      prismlauncher = { # free but installs unfree
        executable = "${pkgs.prismlauncher}/bin/prismlauncher";
        profile = "${pkgs.firejail}/etc/firejail/prismlauncher.profile";
        desktop = "${pkgs.prismlauncher}/share/applications/org.prismlauncher.PrismLauncher.desktop";
      };
    };
  };

  environment.systemPackages = lib.mkAfter (with pkgs; [
    home-manager

    gh

    onionshare
    jocalsend

    libsecret

    nodejs_24
    php
    mise
    mold
    yarn
    wget

    ffmpeg

    bottles

    # Cybersecurity
    nmap
    wireshark
    metasploit
    aircrack-ng
    hashcat
    arp-scan

    yt-dlp

    # aerc # tui email client
    bluetui
    bottom # Terminal task manager
    youtube-tui
    impala
    joplin-cli

    imv # image viewer
    mpv # video viewer

    # web development
    brave

    foot # terminal

    fd # fast directory search
    ripgrep # Easy file content search
    zoxide # smarter cd

    toybox

    sdbus-cpp_2
    sdbus-cpp
    fmt_9

    kdePackages.dolphin

    avfs
    p7zip unzip zip unrar atool

    gcolor3

    wl-clipboard # Clipboard support for some programs
    playerctl # Media shortcuts
    imagemagickBig # Create, edit, compose, or convert bitmap images
    hyprpicker # color picker
    python3
    python313Packages.pygobject3
    gtk3
    sassc
    gnumake
    gnused
    glib.dev
    sbclPackages.cl-cffi-gtk-gdk-pixbuf
    librsvg
    bc
    imagemagick
    socat
    jq
    mesa-demos
  ]);
}
