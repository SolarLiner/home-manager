{
  description = "Personal home-manager setup";
  inputs = rec {
    nixpkgs.url = github:nixos/nixpkgs/master;
    flake-utils.url = github:numtide/flake-utils;
    home-manager.url = github:nix-community/home-manager/master;
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
            ./modules/git.nix
            ./modules/firefox.nix
            ./modules/intellij.nix
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
                homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${username}" else "/home/${username}";
                stateVersion = "23.11";
              };
            }
          ];
        });
        workConfiguration = username: {
          inherit pkgs;
          modules = [
            ./home.nix
            ./modules/git.nix
            ./modules/neovim.nix
            ./modules/python.nix
            ./modules/rust.nix
            ./modules/shell.nix
            {
              home = {
                inherit username;
                homeDirectory = if pkgs.stdenv.isDarwin then "/Users/${username}" else "/home/${username}";
                stateVersion = "23.11";
              };
              programs = {
                git.userEmail = "nathan.graule@arturia.com";
                gh.enable = false;
              };
            }
          ];
        };
      in
      {
        packages.homeConfigurations.solarliner = homeManagerConfiguration (configuration "solarliner");
        packages.homeConfigurations.ngraule = homeManagerConfiguration (workConfiguration "ngraule");
        packages.homeConfigurations.nathangraule = homeManagerConfiguration (workConfiguration "nathangraule");
        packages.homeConfigurations.nixos = homeManagerConfiguration (configuration "nixos");
      });
}
