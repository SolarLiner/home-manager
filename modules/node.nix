{ pkgs, ... }:
{
  programs.zsh.oh-my-zsh.plugins = ["nvm"];
  programs.zsh.initExtra = ''
    # NVM
    export NVM_DIR=$HOME/.local/share/nvm
    if [[ ! -e $NVM_DIR ]]; then
      git clone https://github.com/nvm-sh/nvm.git $NVM_DIR
    fi
    source $NVM_DIR/nvm.sh
    source $NVM_DIR/bash_completion
  '';
}
