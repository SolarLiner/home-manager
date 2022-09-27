{ pkgs, ... }:
{
  programs.zsh.initExtra = ''
    # Pyenv
    export PYENV_ROOT=$HOME/.local/share/pyenv
    if [[ ! -e $PYENV_ROOT ]]; then
      git clone https://github.com/pyenv/pyenv.git $PYENV_ROOT
    else
      export PATH=$PYENV_ROOT/bin:$PATH
      eval "$(pyenv init --path)"
      # eval "$(pyenv virtualenv-init -)"
    fi
  '';
}
