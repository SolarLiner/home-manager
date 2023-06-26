{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Utilities
    docker-buildx
    docker-compose
    google-cloud-sdk
    awscli2
    aws-sam-cli
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
    # Language tooling
    #coq
    mold
    nixfmt
    docker-compose
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
