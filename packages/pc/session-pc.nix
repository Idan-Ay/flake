{
  services.dbus.implementation = "dbus";

  zramSwap = {
    enable = true;
    memoryPercent = 15;    # ~4.8GB out of 32GB RAM
    algorithm = "zstd";    # Fast and efficient compression
  };

  services.evremap = {
    settings = {
      device_name = "Evision RGB Keyboard";
    };
  };
}
