{ pkgs, ... }:
{
  programs.opam = {
    enable = false;
    enableZshIntegration = true;
  };
}
