{ config, lib, pkgs, ... }:
with lib.lists;
let
  isWSL = config.home.username != "solarliner";
in {
  home.packages = with pkgs; [ zellij ];
  programs.kitty = {
    enable = !isWSL;
    font = {
      package = pkgs.iosevka;
      name = "Iosevka";
      size = 10;
    };
    settings = {
      adjust_line_height = "130%";
      disable_ligatures = "cursor";
      enable_audio_bell = false;
      visual_bell_duration = "0.1";
      window_margin_width = 0;
      tab_bar_style = "powerline";
    };
    shellIntegration = {
      mode = "enabled";
      enableZshIntegration = true;
    };
    theme = "Material Dark";
    extraConfig = "shell zellij a -c main";
  };
}
