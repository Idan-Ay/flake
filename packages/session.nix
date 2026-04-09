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

  systemd.user.services.mpd-mpris = {
    enable = true;
    wantedBy = [ "default.target" ];
    description = "mpd mpris bridge";
    serviceConfig = {
      Type = "simple";
      ExecStart = "/run/current-system/sw/bin/mpd-mpris";
    };
  };

  programs.niri = {
    enable = true;
    useNautilus = false;
    package = niri.packages.x86_64-linux.default;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
    config = {
      common = {
        default = [ "gtk" ];
      };
      niri = {
        default = [
          "gtk"
          "gnome"
        ];
        "org.freedesktop.impl.portal.ScreenCast" = [ "gnome" ];
        "org.freedesktop.impl.portal.Screenshot" = [ "gnome" ];
      };
    };
  };

  environment.sessionVariables = {
    XDG_CURRENT_DESKTOP = "niri";
    XDG_SESSION_TYPE = "wayland";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION=1;
    QT_AUTO_SCREEN_SCALE_FACTOR=1;
  };

  environment.variables = {
    QT_STYLE_OVERRIDE = "kvantum-dark";
    QT_QPA_PLATFORMTHEME = "kde";
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
    "inode/directory" = "pcmanfm.desktop";
    "image/jpeg" = "imv.desktop";
    "image/png" = "imv.desktop";
    "image/gif" = "imv.desktop";
    "image/bmp" = "imv.desktop";
    "image/webp" = "imv.desktop";

    "x-scheme-handler/http" = "qutebrowser.desktop";
    "x-scheme-handler/https" = "qutebrowser.desktop";
    "text/html" = "qutebrowser.desktop";
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

  services = {
    desktopManager.plasma6.enable = true;
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
  };

  zramSwap = {
    enable = true;
    memoryPercent = 15;    # ~4.8GB out of 32GB RAM
    algorithm = "zstd";    # Fast and efficient compression
  };

  environment.systemPackages = lib.mkAfter (with pkgs; [
    xwayland-satellite

    mpd-mpris # exposing mpd to mpris

    libsForQt5.qtstyleplugin-kvantum
    kdePackages.qtstyleplugin-kvantum
    qt6.qtwayland
    qt5.qtwayland


    quickshell
    vicinae
  ]);

  security.sudo.enable = true;
}
