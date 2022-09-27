{ pkgs, ... }:
{
  programs.opam = {
    enable = true;
    enableZshIntegration = true;
  };
}
