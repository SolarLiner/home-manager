{ pkgs, ... }:
{
  xdg.configFile."environment.d/10-firefox.conf".text = ''
    MOZ_ENABLE_WAYLAND=1
  '';
}
