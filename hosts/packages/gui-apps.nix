{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    kitty            # GPU-accelerated terminal
    google-chrome    # unfree
    vscode           # Visual Studio Code (unfree, full version)

    mate.engrampa    # Archive manager
  ];

  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [
      thunar-archive-plugin
    ];
  };
}