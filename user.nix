{ pkgs, user, ... }:

{
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "input" "docker" ];
    shell = pkgs.fish;
  };
  nix.settings.trusted-users = [ "your-username" ];

  time.timeZone = "Europe/Berlin";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
        LC_TIME = "de_DE.UTF-8";        # German-style dates (e.g. 26.07.2025)
        LC_MONETARY = "de_DE.UTF-8";    # Currency: € instead of $
        LC_MEASUREMENT = "de_DE.UTF-8"; # metric instead of imperial
        LC_NUMERIC = "en_US.UTF-8";     # keeps dot (.) as decimal separator
    };
  };
  console.keyMap = "us";

  services.getty.autologinUser = "${user}";
}
