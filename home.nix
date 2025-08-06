{ config, pkgs, lib, ... }:

{
  programs.home-manager.enable = true;

  home.username = "idan";
  home.homeDirectory = "/home/idan";
  home.stateVersion = "25.05";
  
  xdg.configFile = {
    "kitty/kitty.conf".source = ./config/kitty.conf;
  };

  wayland.windowManager.hyprland = {
  enable = true;
  settings = {
    # Input configuration
    input = {
      kb_layout = "us";
      follow_mouse = 1;
    };

    # Gestures
    gestures = {
      workspace_swipe = true;
    };

    # General settings
    general = {
      gaps_in = 5;
      gaps_out = 15;
      border_size = 0;
      layout = "master";
    };

    # Window decorations
    decoration = {
      rounding = 10;

      blur = {
        enabled = true;
        size = 5;
        passes = 3;
      };
    };

    # Animations
    animations = {
      enabled = true;
      bezier = [
        "myBezier, 0.05, 0.9, 0.1, 1.0"
      ];
      animation = [
        "windows, 1, 7, myBezier"
        "fade, 1, 7, myBezier"
        "workspaces, 1, 7, myBezier"
      ];
    };

    # Startup applications
    exec-once = [
      "kitty"
    ];

    # Keybindings
    bind = [
      # Media controls
      ", XF86AudioPlay, exec, quickshell --ipc mpris playPause"
      ", XF86AudioNext, exec, quickshell --ipc mpris next"
      ", XF86AudioPrev, exec, quickshell --ipc mpris previous"

      # Shell controls
      "SUPER, Space, exec, quickshell --ipc drawers \"toggle\" \"launcher\""
      "SUPER, L, exec, quickshell --ipc lock lock"
      "SUPER SHIFT, S, exec, quickshell --ipc picker open"
      "SUPER CTRL SHIFT, S, exec, quickshell --ipc picker openFreeze"

      # Dashboard and session
      "SUPER, W, exec, quickshell --ipc drawers \"toggle\" \"dashboard\""
      "SUPER, Escape, exec, quickshell --ipc drawers \"toggle\" \"session\""

      # Apps
      "SUPER, RETURN, exec, kitty"
      "SUPER, N, exec, kitty -e nnn"
      "SUPER, B, exec, google-chrome-stable"
      "SUPER, O, exec, obsidian"
      "SUPER, E, exec, blender"
      "SUPER, C, exec, code"

      # Bookmarks
      "SUPER, G, exec, google-chrome-stable 'https://chatgpt.com'"
      "SUPER, T, exec, google-chrome-stable 'https://translate.google.com/details?sl=en&tl=de&op=translate'"
      "SUPER, Y, exec, google-chrome-stable 'https://www.youtube.com'"
      "SUPER, M, exec, google-chrome-stable 'https://mail.google.com'"
      "SUPER, R, exec, google-chrome-stable 'https://www.desmos.com/calculator?lang=en'"
      "SUPER, D, exec, google-chrome-stable 'https://discord.com/app'"

      # Window controls
      "SUPER, Q, killactive"
      "SUPER, F, fullscreen"
      "SUPER, V, togglefloating"

      # Workspaces
      "SUPER, 1, workspace, 1"
      "SUPER, 2, workspace, 2"
      "SUPER, 3, workspace, 3"
      "SUPER, 4, workspace, 4"
      "SUPERSHIFT, 1, movetoworkspace, 1"
      "SUPERSHIFT, 2, movetoworkspace, 2"
      "SUPERSHIFT, 3, movetoworkspace, 3"
      "SUPERSHIFT, 4, movetoworkspace, 4"
    ];

    bindm = [
      "SUPER, mouse:272, movewindow"
      "SUPER, mouse:273, resizewindow"
    ];
  };
};
}
