{ pkgs, ... }:
{
  home.packages = with pkgs; [ flutter ];
  xdg.configFile."environment.d/10-flutter.conf".text = ''
    CHROME_EXECUTABLE=google-chrome-stable
  '';
}
