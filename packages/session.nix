{ pkgs, lib, ... }:

{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 8384 25565 ];
    allowedUDPPorts = [ 25565 ];
  };

  programs.niri = {
    enable = true;
    useNautilus = false;
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
    XDG_SESSION_DESKTOP = "niri";
  };

  programs.gamemode.enable = true;

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

  environment.systemPackages = lib.mkAfter (with pkgs; [
    xwayland-satellite

    quickshell
    vicinae
  ]);

  security.sudo.enable = true;
}
