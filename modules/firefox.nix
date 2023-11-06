{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  isWSL = config.home.username != "solarliner";
in
{
  xdg.configFile."environment.d/10-firefox.conf" = mkIf (!isWSL) { 
    text = ''
      MOZ_ENABLE_WAYLAND=1
    '';
  };
}
