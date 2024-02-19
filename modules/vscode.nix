{ config, lib, pkgs, isWSL ? false, ... }:
with lib;
{
  home.packages = with pkgs; [
    nixfmt
    nixd
  ];
  home.file.".vscode-server/server-env-setup" = mkIf isWSL {
    source = ./vscode/server-env-setup.sh;
    target = ".vscode-server/server-env-setup";
    executable = true;
  };
}
