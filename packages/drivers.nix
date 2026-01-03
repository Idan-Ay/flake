{
  services.xserver.wacom.enable = true;
  
  boot.blacklistedKernelModules = [ "nouveau" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  boot.initrd.kernelModules = [
    "nvidia"
    "nvidia_modeset"
    "nvidia_drm"
    "nvidia_uvm"
    "amdgpu"
  ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    open = true;
    nvidiaSettings = false;

    prime = {
      offload.enable = true;

      # Display GPU (AMD)
      intelBusId = "PCI:10:0:0";
      # Render GPU (NVIDIA)
      nvidiaBusId = "PCI:9:0:0";
    };
  };

  environment.etc."nvidia/nvidia-application-profiles-rc.d/50-limit-free-buffer.json".source = 
    ../config/nvidia/50-limit-free-buffer.json;

  services.xserver.videoDrivers = [ "nvidia" "amdgpu" ];

  environment.variables = {
    LIBVA_DRIVER_NAME = "nvidia";
  };
}
