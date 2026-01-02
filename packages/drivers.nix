{
  services.xserver.wacom.enable = true;
  
  boot.blacklistedKernelModules = [ "nouveau" ];

  hardware.graphics = {
    enable = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    open = true;
    nvidiaSettings = false;
  };

  environment.etc."nvidia/nvidia-application-profiles-rc.d/50-limit-free-buffer.json".source = 
    ../config/nvidia/50-limit-free-buffer.json;

  services.xserver.videoDrivers = [ "nvidia" ];

  environment.variables = {
    LIBVA_DRIVER_NAME = "nvidia";
  };
}
