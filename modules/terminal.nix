{ pkgs, ... }:
{
  xdg.configFile."kitty/kitty.conf".text =
    let
      theme = builtins.fetchurl {
        url = "https://raw.githubusercontent.com/kdrag0n/base16-kitty/master/colors/base16-material-darker.conf";
        sha256 = "sha256:01rmlpgclvhimr92f0v95301dz73iakgr61zcifcia6054yj12fd";
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
}
