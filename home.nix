{ config, pkgs, lib, ... }:
with lib.lists;
let
  isWSL = config.home.username == "nixos";
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
    docker-compose
    # Other
    git-crypt
  ] ++ optionals (!isWSL) [
    # Fonts
    jetbrains-mono
    iosevka
  ];

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
  programs.git = {
    package = pkgs.gitAndTools.gitFull;
    enable = true;
    difftastic.enable = true;
    lfs.enable = true;
    userName = "Nathan Graule";
    userEmail = "solarliner@gmail.com";
    extraConfig = {
      fetch.prune = true;
    };
  };
  programs.gh = {
    enable = true;
    settings = {
      prompt = "enabled";
      git_protocol = "ssh";
    };
  };
}
