{ pkgs, ... }:
{
  xdg.configFile."kitty/kitty.conf".text =
    let
      theme = builtins.fetchurl {
        url = "https://raw.githubusercontent.com/kdrag0n/base16-kitty/master/colors/base16-material-darker.conf";
        sha256 = "sha256:034vva7pp0qfzjdzdwkfxcdyz8npi81ixn81zx33mrfhn51l68zh";
      };
      # theme = "${packages.nvim-github-theme}/terminal/kitty/github_dark.conf";
    in
    ''
      font_family Iosevka
      font_size 10
      adjust_line_height 130%
      disable_ligatures cursor
      enable_audio_bell no
      visual_bell_duration 0.1
      window_margin_width 0
      tab_bar_style powerline

      include ${theme}

      shell zellij a -c main
      editor nvim
    '';
  xdg.configFile."foot/foot.ini".text =
    let theme = builtins.fetchurl {
      url = "https://codeberg.org/dnkl/foot/raw/branch/master/themes/paper-color-dark";
      sha256 = "sha256:0xwvahsaaw7msbqi66xzgki6y5sqwhrcx5nwap4hkalhin7wjjnp";
    }; in
    ''
      font=JetBrains Mono:size=11
      pad=2x3

      ${builtins.readFile theme}
    '';
}
