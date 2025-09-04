{ config, pkgs, ... }:

{
  services.xserver.wacom.enable = true;

  # Use the official proprietary NVIDIA driver
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = false;  # use proprietary driver
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  environment.etc."nvidia/nvidia-application-profiles-rc.d/50-limit-free-buffer.json".source = 
    ../config/nvidia/50-limit-free-buffer.json;

  services.xserver.videoDrivers = [ "nvidia" ];

  # Recommended for Wayland (Hyprland, Sway, etc.)
  environment.variables = {
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    WLR_NO_HARDWARE_CURSORS = "1";  # workaround for cursor issues
  };

  services.xserver.inputClassSections = [
    {
      identifier = "Huion tablet";
      matchProduct = "HUION";
      driver = "wacom";
    }
  ];
}