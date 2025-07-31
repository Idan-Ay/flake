{ config, pkgs, ... }: 

{
  boot.kernelModules = [ "uinput" ];

  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="input", OPTIONS+="static_node=uinput"
  '';

  services.interception-tools = {
    enable = true;
    plugins = [ pkgs.interception-tools-plugins.dual-function-keys ];
    udevmonConfig = ''
      - JOB: "${pkgs.interception-tools}/bin/intercept -g $DEVNODE | \
              ${pkgs.interception-tools-plugins.dual-function-keys}/bin/dual-function-keys /etc/key-remap.yaml | \
              ${pkgs.interception-tools}/bin/uinput -d $DEVNODE"
        DEVICE:
          EVENTS:
            EV_KEY: [KEY_CAPSLOCK, KEY_J, KEY_K, KEY_I, KEY_L, KEY_F, KEY_U, KEY_H, KEY_C, KEY_V, KEY_X]
    '';
  };

  environment.etc."key-remap.yaml".text =
    builtins.readFile ../config/key-remap.yaml;
}