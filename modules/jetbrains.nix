{ pkgs, ... }:
{
  home.file.".ideavimrc".text = ''
    set clipboard=unnamedplus
    set clipboard+=ideaput
    set command
    set easymotion
    set highlightedyank
    set surround
  '';
  xdg.configFile."environment.d/10-jetbrains.conf".text = ''
    JETBRAINS_TOOLBOX_HOME=$HOME/.local/share/JetBrains/Toolbox
    PATH=$JETBRAINS_TOOLBOX_HOME/scripts:$PATH
  '';
}
