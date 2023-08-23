{ config, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  isWSL = config.home.username == "nixos";
in {
  xdg.configFile."environment.d/10-AWT.conf" = mkIf (!isWSL) {
    text = ''
      _JAVA_AWT_WM_NONREPARENTING=1
    '';
  };
}

