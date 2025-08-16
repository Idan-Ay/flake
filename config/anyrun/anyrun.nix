let
  anyrunFlake = builtins.getFlake "github:anyrun-org/anyrun";
in {
  programs.anyrun = {
      enable = true;
      config = {
        x = { fraction = 0.5; };
        y = { fraction = 0.3; };
        width = { fraction = 0.3; };
        hideIcons = false;
        ignoreExclusiveZones = false;
        layer = "overlay";
        hidePluginInfo = false;
        closeOnClick = false;
        showResultsImmediately = false;
        maxEntries = null;
      };

      plugins = [
        anyrunFlake.packages.${pkgs.system}.applications
        anyrunFlake.packages.${pkgs.system}.websearch
        anyrunFlake.packages.${pkgs.system}.dictionary
        anyrunFlake.packages.${pkgs.system}.files
        anyrunFlake.packages.${pkgs.system}.translate
      ];

      extraCss = builtins.readFile ./style.css;
    };
}
