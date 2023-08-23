{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  isWSL = config.home.username == "nixos";
in
{
  xdg.configFile."environment.d/10-firefox.conf" = mkIf (!isWSL) { 
    text = ''
      MOZ_ENABLE_WAYLAND=1
    '';
  };
}
