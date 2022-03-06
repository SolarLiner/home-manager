{
  description = "A very basic flake";

  inputs = {
    flake-utils.url = github:numtide/flake-utils;
  };

  outputs = { self, nixpkgs, flake-utils }: with flake-utils.lib; eachSystem ["x86_64-linux" "x86_64-darwin" "aarch64-darwin"] (system:
  let
    pkgs = import nixpkgs { inherit system; };
    system-map = {
      aarch64-darwin = "aarch64-apple-darwin";
      x86_64-linux = "x86_64-unknown-linux-gnu";
      x86_64-darwin = "x86_64-apple-darwin";
    };
  in rec {
    lib.makeDeno = { version, sha256 ? "" }: pkgs.stdenvNoCC.mkDerivation rec {
      pname = "deno";
      inherit version;
      src = builtins.fetchTarball {
        url = "https://github.com/denoland/deno/releases/download/v${version}/deno-${system-map.${system}}.zip";
        inherit sha256;
      };
      dontUnpack = true;
      phases = ["installPhase"];
      installPhase = ''
        mkdir -p $out/bin
        cp $src $out/bin/${pname}
      '';
    };
    packages.deno = lib.makeDeno { version = "1.19.2"; sha256 = "04v48zjydmnj9gkfh5197m36fwmgrp8lk98lkvhcffx4c7lfgyxn"; };
    defaultPackage = packages.deno;

    apps.deno = mkApp { drv = self.packages.deno; };
    defaultApp = apps.deno;
  });
}
