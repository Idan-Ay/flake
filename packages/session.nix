{ pkgs, lib, ... }:

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

  services.earlyoom.enable = true;

  services.resolved = {
    enable = true;
    settings = {
      Resolve = {
        DNS = [
          "45.90.28.0#76ddb.dns.nextdns.io"
          "2a07:a8c0::#764ddb.dns.nextdns.io"
          "45.90.30.0#764ddb.dns.nextdns.io"
          "2a07:a8c1::#764ddb.dns.nextdns.io"
        ];
        DNSOverTLS = true;
      };
    };
  };

  services.tor = {
    enable = true;
    client.enable = true;
  };

  services.avahi.enable = true;

  services.cron.systemCronJobs = [
    "*/15 * * * * joplin sync"
  ];

  systemd.user.services.mpd-mpris = {
    enable = true;
    wantedBy = [ "default.target" ];
    description = "mpd mpris bridge";
    serviceConfig = {
      Type = "simple";
      ExecStart = "/run/current-system/sw/bin/mpd-mpris";
    };
  };

  # systemd.services.newTabPagePHPServer = {
    # description = "PHP Server";
    # wantedBy = [ "multi-user.target" ];
    # after = [ "network.target" ];
    # serviceConfig = {
      # Type = "simple";
      # User = "${user}";
      # WorkingDirectory = "/etc/newTabPage.html";
      # ExecStart = "${pkgs.php}/bin/php -S 0.0.0.0:8000";  # Adjust port as needed
      # Restart = "always";
      # RestartSec = "5";
      # StandardOutput = "syslog";
      # StandardError = "syslog";
    # };
  # };

  systemd.services.php-newtabpage-server = {
    description = "PHP newTabPage server";
    after = ["network.target"];
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      User = "root";
      ExecStart = "${pkgs.php}/bin/php -S 0.0.0.0:80 /etc/newTabPage.html";
      Restart = "always";
    };
  };

  environment.etc."newTabPage.html".text = lib.mkForce ''
    <!DOCTYPE html>
    <html>
    <head>
    <title>New Tab</title>
    </head>
    </html>
  '';

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
    TERMCMD = "foot --title filechooser";

    EDITOR = "nvim";
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

  services.evremap = {
    enable = true;
    settings = {
      dual_role = [
        {
          input = "KEY_CAPSLOCK";
          tap = [ "KEY_ESC" ];
          hold = [ "KEY_RIGHTCTRL" ];
        }
      ];

      remap = [
        {
          input = [ "KEY_ESC" ];
          output = [ "KEY_CAPSLOCK" ];
        }
        {
          input = [ "KEY_RIGHTCTRL" "KEY_H" ];
          output = [ "KEY_LEFT" ];
        }
        {
          input = [ "KEY_RIGHTCTRL" "KEY_J" ];
          output = [ "KEY_DOWN" ];
        }
        {
          input = [ "KEY_RIGHTCTRL" "KEY_K" ];
          output = [ "KEY_UP" ];
        }
        {
          input = [ "KEY_RIGHTCTRL" "KEY_L" ];
          output = [ "KEY_RIGHT" ];
        }
        {
          input = [ "KEY_RIGHTCTRL" "KEY_I" ];
          output = [ "KEY_HOME" ];
        }
        {
          input = [ "KEY_RIGHTCTRL" "KEY_A" ];
          output = [ "KEY_END" ];
        }
        {
          input = [ "KEY_RIGHTCTRL" "KEY_U" ];
          output = [ "KEY_PAGEUP" ];
        }
        {
          input = [ "KEY_RIGHTCTRL" "KEY_D" ];
          output = [ "KEY_PAGEDOWN" ];
        }
      ];
    };
  };

  programs.fish = {
    enable = true;

    loginShellInit = builtins.readFile ../scripts/loginShellInit.fish;
    shellInit = builtins.readFile ../scripts/shellInit.fish;
    interactiveShellInit = builtins.readFile ../scripts/interactiveShellInit.fish;
  };
  users.defaultUserShell = pkgs.fish;

  programs.dconf.enable = true;

  environment.systemPackages = lib.mkAfter (with pkgs; [
    xwayland-satellite

    mpvpaper

    evsieve

    # libsForQt5.qtstyleplugin-kvantum
    kdePackages.qtstyleplugin-kvantum
    kdePackages.plasma-integration
    # kdePackages.kcolorscheme

    mpd-mpris # exposing mpd to mpris

    quickshell
  ]);

  security.sudo.enable = true;
}
