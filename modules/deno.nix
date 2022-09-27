{ pkgs, lib, stdenvNoCC, ... }:
let
#     makeDeno = { version, sha256 ? "" }: pkgs.stdenvNoCC.mkDerivation rec {
#       pname = "deno";
#       inherit version;
#       src = builtins.fetchTarball {
#         url = "https://github.com/denoland/deno/releases/download/v${version}/deno-${system-map.${system}}.zip";
#         inherit sha256;
#       };
#       dontUnpack = true;
#       phases = ["installPhase"];
#       installPhase = ''
#         mkdir -p $out/bin
#         cp $src $out/bin/${pname}
#       '';
#     };
#     deno = lib.makeDeno { version = "1.19.2"; sha256 = "04v48zjydmnj9gkfh5197m36fwmgrp8lk98lkvhcffx4c7lfgyxn"; };
in {
  home.packages = with pkgs; [ deno ];
}
