{ config, lib, pkgs, ... }:
with lib;
let isWSL = config.home.username != "solarliner";
in {
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
