{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # Utilities
    dapr-cli
    diesel-cli
    docker-compose
    tree
    zellij
    # jq
    cachix
    ripgrep
    htop
    neofetch
    pv
    # Language tooling
    coq
    mold
    nixfmt
    docker-compose
    pulumi-bin
    # Fonts
    jetbrains-mono
    iosevka
  ];

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
  programs.git = {
    package = pkgs.gitAndTools.gitFull;
    enable = true;
    delta.enable = true;
    lfs.enable = true;
    userName = "Nathan Graule";
    userEmail = "solarliner@gmail.com";
  };
  programs.gh = {
    enable = true;
    settings = {
      prompt = "enabled";
      git_protocol = "ssh";
    };
  };
}
