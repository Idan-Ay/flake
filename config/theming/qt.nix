{ pkgs, ... }:

let
  theme = "KvLibadwaita";
in
{
  home.packages = with pkgs; [
    kvantum
    qt5ct
    qt6ct
  ];

  qt = {
    enable = true;
    platformTheme = "qt5ct";  # qt6ct handles Qt6 apps
    style.name = "kvantum";   # force Kvantum as the Qt style
  };

  # Tell Kvantum which theme to use
  xdg.configFile."Kvantum/kvantum.kvconfig".text = ''
    [General]
    theme=${theme}
  '';

  # Optional translucency tweaks (works with most Kvantum themes)
  xdg.configFile."Kvantum/${theme}/${theme}.kvconfig".text = ''
    [General]
    translucent_windows=true
    window_opacity=0.92
    menu_opacity=0.92
    tooltip_opacity=0.94
    combobox_popup_opacity=0.92
  '';
}