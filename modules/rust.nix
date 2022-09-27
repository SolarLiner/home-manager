{ pkgs, ... }:
{
  programs.zsh = {
    initExtra = ''
      export RUSTUP_HOME=$HOME/.local/share/rustup
      export CARGO_HOME=$HOME/.local/share/cargo
      if [[ ! -e $CARGO_HOME ]]; then
        curl https://sh.rustup.rs -sSf | sh -s -- --no-modify-path -y
        export PATH=$CARGO_HOME/bin:$PATH
      elif [[ -e $CARGO_HOME ]]; then
        export PATH=$CARGO_HOME/bin:$PATH
      fi
    '';
  };
  xdg.configFile."cargo/config".text = ''
    [target.x86_64-unknown-linux-gnu]
    linker="clang"
    rustflags = [
        "-C", "link-arg=-fuse-ld=${pkgs.mold}/bin/mold",
    ]
  '';
  xdg.configFile."environment.d/99-rustup.conf".text = ''
    RUSTUP_HOME=$HOME/.local/share/rustup
    CARGO_HOME=$HOME/.local/share/cargo
    PATH=$CARGO_HOME/bin:$PATH
  '';
}
