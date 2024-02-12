{ config, pkgs, lib, ... }:
with lib.lists;
let
  inherit (config.home) username;
  isWSL = username != "solarliner";
in {
  home.packages = with pkgs; [
    # Utilities
    docker-buildx
    docker-compose
    tree
    zellij
    jq
    jiq
    cachix
    ripgrep
    htop
    neofetch
    pv
    kubeseal
    nix-output-monitor
    # Language tooling
    #coq
    mold
    nixfmt
    nixd
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
