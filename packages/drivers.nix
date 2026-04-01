{ config, lib, pkgs, ...}:
{
  boot.blacklistedKernelModules = [ "nouveau" ];

  # boot.kernelPackages = pkgs.linuxPackages;

  # boot.initrd.kernelModules = [
    # "amdgpu"
    # "nvidia"
    # "nvidia_modeset"
    # "nvidia_drm"
    # "nvidia_uvm"
  # ];
  # boot.kernelModules = [ "nvidia_uvm" ];

  hardware.steam-hardware.enable = true;

  powerManagement = {
    enable = true;
    cpuFreqGovernor = "performance";
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = false;
    nvidiaSettings = false;
    package = config.boot.kernelPackages.nvidiaPackages.latest;

    prime = {
      sync.enable = true;
      # offload.enable = false;
      # offload.enableOffloadCmd = false;

      amdgpuBusId = "PCI:10:0:0";
      nvidiaBusId = "PCI:9:0:0";
    };
  };

  # environment.etc."../../nvidia/nvidia-application-profiles-rc.d/50-limit-free-buffer.json".source = 
    # ../config/nvidia/50-limit-free-buffer.json;

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      nvidia-vaapi-driver
      libva
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };

  environment.sessionVariables = {
    # Force NVIDIA VA-API
    LIBVA_DRIVER_NAME = "nvidia";
    NVD_BACKEND = "direct";

    # Wayland + NVIDIA
    MOZ_ENABLE_WAYLAND = "1";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    __NV_PRIME_RENDER_OFFLOAD = "1";

    # Firefox sandbox workaround (required for VA-API on NVIDIA)
    MOZ_DISABLE_RDD_SANDBOX = "1";
  };

  environment.variables = {
    LIBVA_DRIVER_NAME = "nvidia";
    NVD_BACKEND = "direct";
    MOZ_DISABLE_RDD_SANDBOX = "1";
  };

  environment.systemPackages = lib.mkAfter (with pkgs; [
    libva-utils
  ]);
}
