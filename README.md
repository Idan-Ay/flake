This is a highly oppinionated nixos configuration, made for my specific system.

If you want to use this configuration, you would likely need to fork and modify it.

Packages:
In the packages folder, you might want to modify drivers.nix if you don't have a nvidia gpu.
You might also want to modify latest.nix. There are all the packages that should be on the latest version.
Tools.nix has all the packages that shouldn't be on the latest version for stability.

Quickshell:
The Quickshell configuration is made under the assumption, that there is only one main output, that should have a bar and it's information.
If that is not the case for you, you can modify config/Quickshell/Modules/Bar.qml, config/Quickshell/Services/NiriService.qml and config/Quickshell/Services/Screens.qml to fit your needs.

Wallpapers:
The Wallpapers you can change in config/Wallpapers/

Niri:
The niri config is in config/niri.kdl

NVim:
The NVim config is in config/nvim.nix
