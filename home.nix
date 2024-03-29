{ config, pkgs, lib, isWSL ? false, ... }:
with lib.lists;
let
  inherit (config.home) username;
in {
  home.packages = with pkgs; [
    # Utilities
    # Language tooling
    #coq
    docker-compose
    # Other
    git-crypt
  ] ++ optionals (!isWSL) [
    # Fonts
    jetbrains-mono
    iosevka
  ] ++ optionals isWSL [curl wget];

  fonts.fontconfig.enable = !isWSL && !pkgs.stdenv.isDarwin;

  programs.home-manager.enable = true;
}
