{ config, lib, pkgs, isWSL ? false, ... }:
let
  inherit (lib) mkIf;
  inherit (pkgs) stdenv;
in {
  home.file.".ideavimrc" = {
    text = ''
      set scrolloff=5
      set clipboard=unnamedplus
      set clipboard+=ideaput
      set command
      set commentary
      set easymotion
      set highlightedyank
      set incsearch
      set surround
    '';
  };
  xdg.configFile."environment.d/10-jetbrains.conf" = { 
    enable = !stdenv.isDarwin;
    text = ''
      JETBRAINS_TOOLBOX_HOME=$HOME/.local/share/JetBrains/Toolbox
      PATH=$JETBRAINS_TOOLBOX_HOME/scripts:$PATH
    '';
  };
  xdg.configFile."environment.d/10-AWT.conf" = mkIf (!isWSL) {
    text = ''
      _JAVA_AWT_WM_NONREPARENTING=1
    '';
  };
}

