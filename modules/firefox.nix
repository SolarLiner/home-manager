{ config, lib, pkgs, isWSL ? false, ... }:
let
  inherit (lib) mkIf;
in
{
  xdg.configFile."environment.d/10-firefox.conf" = mkIf (!isWSL) { 
    text = ''
      MOZ_ENABLE_WAYLAND=1
    '';
  };
}
