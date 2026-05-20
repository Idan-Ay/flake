{ pkgs, lib, user, ... }:

{
  networking.networkmanager = {
    enable = true;
    wifi.backend = "iwd";
  };

  security.polkit = {
    enable = true;
    extraConfig = ''
      polkit.addRule(function(action, subject) {
          if (action.id == "org.freedesktop.systemd1.manage-units" &&
               action.lookup("unit") == "tiny-dfr.service") {
              return polkit.Result.YES;
          }
      });
    '';
  };

  hardware.apple.touchBar.enable = true;

  boot.extraModprobeConfig = ''
    options hid_apple swap_fn_leftctrl=1
  '';

  environment.etc."tiny-dfr/config.toml".text = lib.mkForce ''
    AdaptiveBrightness = true
    MediaLayerDefault = true
    DoublePressSwitchLayers = 200
    MediaLayerKeys = [
      { Icon = "brightness_low",  Action = "BrightnessDown" },
      { Icon = "brightness_high", Action = "BrightnessUp"   },
      { Icon = "mic_off",         Action = "MicMute"        },
      { Icon = "fast_rewind",     Action = "PreviousSong"   },
      { Icon = "play_pause",      Action = "PlayPause"      },
      { Icon = "fast_forward",    Action = "NextSong"       },
      { Icon = "volume_off",      Action = "Mute"           },
      { Icon = "volume_down",     Action = "VolumeDown"     },
      { Icon = "volume_up",       Action = "VolumeUp"       }
    ]
    PrimaryLayerKeys = [
      { Text = "F1",  Action = "F1"  },
      { Text = "F2",  Action = "F2"  },
      { Text = "F3",  Action = "F3"  },
      { Text = "F4",  Action = "F4"  },
      { Text = "F5",  Action = "F5"  },
      { Text = "F6",  Action = "F6"  },
      { Text = "F7",  Action = "F7"  },
      { Text = "F8",  Action = "F8"  },
      { Text = "F9",  Action = "F9"  },
      { Text = "F10", Action = "F10" },
      { Text = "F11", Action = "F11" },
      { Text = "F12", Action = "F12" }
    ]
  '';

  services.upower.enable = true;

  environment.systemPackages = lib.mkAfter (with pkgs; [
    brightnessctl
    tiny-dfr
  ]);
}
