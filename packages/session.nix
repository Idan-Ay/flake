{ pkgs, lib, niri, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

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

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 8384 25565 ];
    allowedUDPPorts = [ 25565 ];
  };

  services.resolved = {
    enable = true;
    extraConfig = ''
      DNS=45.90.28.0#764ddb.dns.nextdns.io
      DNS=2a07:a8c0::#764ddb.dns.nextdns.io
      DNS=45.90.30.0#764ddb.dns.nextdns.io
      DNS=2a07:a8c1::#764ddb.dns.nextdns.io
      DNSOverTLS=yes
    '';
  };

  systemd.user.services.mpd-mpris = {
    enable = true;
    wantedBy = [ "default.target" ];
    description = "mpd mpris bridge";
    serviceConfig = {
      Type = "simple";
      ExecStart = "/run/current-system/sw/bin/mpd-mpris";
    };
  };

  xdg.portal = {
    enable = true;

    config.common = {
      default = [ "gtk" "gnome" ];
      "org.freedesktop.impl.portal.FileChooser" = "termfilechooser";
      "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
      "org.freedesktop.impl.portal.Screenshot" = [ "gnome" ];
    };

    extraPortals = [
      pkgs.xdg-desktop-portal-termfilechooser
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
  };

  environment.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    QT_QPA_PLATFORM = "wayland";
  };

  environment.variables = {
    QT_STYLE_OVERRIDE = "kvantum";
    # QT_QPA_PLATFORMTHEME = "qt5ct";

    # GTK_USE_PORTAL = "1"; # legacy
    # GDK_DEBUG = "portals";

    TERMCMD = "foot --title filechooser";
  };

  services.greetd = {
    enable = true;

    settings = {
      default_session = {
        command = "niri-session";
        user = "idan";
      };
    };
  };

  xdg.mime.defaultApplications = {
    "inode/directory" = "yazi.desktop";
    "image/jpeg" = "imv.desktop";
    "image/png" = "imv.desktop";
    "image/gif" = "imv.desktop";
    "image/bmp" = "imv.desktop";
    "image/webp" = "imv.desktop";

    "x-scheme-handler/http" = "qutebrowser.desktop";
    "x-scheme-handler/https" = "qutebrowser.desktop";
    "text/html" = "qutebrowser.desktop";

    "x-scheme-handler/terminal" = "foot.desktop";
  };

  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        settings = {
          main = {
            capslock = "overload(capslock, esc)";
            esc = "overload(control, capslock)";
          };
          capslock = {
            h = "left";
            k = "up";
            j = "down";
            l = "right";
            a = "end";
            i = "home";
            u = "pageup";
            d = "pagedown";
          };
        };
      };
    };
  };

  programs.fish = {
    enable = true;

    loginShellInit = builtins.readFile ../scripts/loginShellInit.fish;
    shellInit = builtins.readFile ../scripts/shellInit.fish;
    interactiveShellInit = builtins.readFile ../scripts/interactiveShellInit.fish;
  };
  users.defaultUserShell = pkgs.fish;

  zramSwap = {
    enable = true;
    memoryPercent = 15;    # ~4.8GB out of 32GB RAM
    algorithm = "zstd";    # Fast and efficient compression
  };

  programs.dconf.enable = true;

  environment.systemPackages = lib.mkAfter (with pkgs; [
    xwayland-satellite

    niri.packages.x86_64-linux.default

    mpvpaper

    # libsForQt5.qtstyleplugin-kvantum
    kdePackages.qtstyleplugin-kvantum
    kdePackages.plasma-integration
    # kdePackages.kcolorscheme

    mpd-mpris # exposing mpd to mpris

    quickshell
    vicinae
  ]);

  security.sudo.enable = true;
}
