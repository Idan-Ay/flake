{ pkgs, lib, macos}:

{
    environment.systemPackages = lib.mkAfter (with pkgs; [
        macos.packages.${system}.default
    ]);
}