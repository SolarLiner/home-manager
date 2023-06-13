{ pkgs, ... }:
{
  xdg.configFile."environment.d/10-AWT.conf".text = ''
    _JAVA_AWT_WM_NONREPARENTING=1
  '';
}

