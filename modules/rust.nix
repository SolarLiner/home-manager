{ pkgs, ... }:
{
  home.packages = with pkgs; [ rustup mold ];
  xdg.configFile."cargo/config".text = ''
    [target.x86_64-unknown-linux-gnu]
    linker="clang"
    rustflags = [
        "-C", "link-arg=-fuse-ld=${pkgs.mold}/bin/mold",
    ]
  '';
  xdg.configFile."environment.d/99-rustup.conf".text = ''
    CARGO_HOME=$HOME/.local/share/cargo
    PATH=$CARGO_HOME/bin:$PATH
  '';
}
