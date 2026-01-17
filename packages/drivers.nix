{
  boot.blacklistedKernelModules = [ "nouveau" ];

  hardware.graphics.enable = true;

  boot.initrd.kernelModules = [
    "amdgpu"
    "nvidia"
    "nvidia_modeset"
    "nvidia_drm"
    "nvidia_uvm"
  ];

  hardware.nvidia = {
    # modesetting.enable = true;
    powerManagement.enable = true;
    open = true;
    nvidiaSettings = false;

    prime = {
      # sync.enable = true;
      offload.enable = true;
      offload.enableOffloadCmd = true;

      # Display GPU (AMD)
      amdgpuBusId = "PCI:10:0:0";
      # Render GPU (NVIDIA)
      nvidiaBusId = "PCI:9:0:0";
    };
  };

  environment.etc."nvidia/nvidia-application-profiles-rc.d/50-limit-free-buffer.json".source = 
    ../config/nvidia/50-limit-free-buffer.json;

  services.xserver.videoDrivers = [ "nvidia" "amdgpu" ];
}
