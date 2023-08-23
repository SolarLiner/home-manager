{ config, pkgs, lib, ... }:
let
  inherit (lib) mkIf;
  isWSL = config.home.username == "nixos";
in {
  home.file.".ideavimrc" = mkIf (!isWSL) {
    text = ''
      set clipboard=unnamedplus
      set clipboard+=ideaput
      set command
      set easymotion
      set highlightedyank
      set surround
    '';
  };
  xdg.configFile."environment.d/10-jetbrains.conf" = mkIf (!isWSL) { 
    text = ''
      JETBRAINS_TOOLBOX_HOME=$HOME/.local/share/JetBrains/Toolbox
      PATH=$JETBRAINS_TOOLBOX_HOME/scripts:$PATH
    '';
  };
}
