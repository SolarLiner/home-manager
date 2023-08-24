{
  description = "Personal home-manager setup";
  inputs = rec {
    nixpkgs.url = github:nixos/nixpkgs/nixos-23.05;
    flake-utils.url = github:numtide/flake-utils;
    home-manager.url = github:nix-community/home-manager/release-23.05;
    nixd.url = github:nix-community/nixd;
  };
  outputs = inputs:
    with inputs.flake-utils.lib; eachDefaultSystem (system:
      let
        inherit (inputs.home-manager.lib) homeManagerConfiguration;
        pkgs = import inputs.nixpkgs {
          inherit system;
          overlays = [
            (final: prev: {
              nixd = inputs.nixd;
            })
          ];
        };
      	configuration = (username: {
          inherit pkgs;
          modules = [
            ./home.nix
            ./modules/email.nix
            ./modules/firefox.nix
            ./modules/intellij.nix
            # ./modules/flutter.nix
            ./modules/jetbrains.nix
            ./modules/neovim.nix
            ./modules/node.nix
            ./modules/ocaml.nix
            ./modules/python.nix
            ./modules/rust.nix
            ./modules/shell.nix
            ./modules/terminal.nix
            ./modules/vscode.nix
            {
              home = {
                inherit username;
                homeDirectory = "/home/${username}";
                stateVersion = "23.05";
              };
            }
          ];
        });
      in
      {
        packages.homeConfigurations.solarliner = homeManagerConfiguration (configuration "solarliner");
        packages.homeConfigurations.nixos = homeManagerConfiguration (configuration "nixos");
      });
}
