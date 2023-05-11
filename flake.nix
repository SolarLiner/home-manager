{
  description = "Personal home-manager setup";
  inputs = rec {
    nixpkgs.url = github:nixos/nixpkgs/nixos-22.11;
    flake-utils.url = github:numtide/flake-utils;
    flake-utils.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = github:nix-community/home-manager;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs:
    let username = "solarliner"; in
    with inputs.flake-utils.lib; eachDefaultSystem (system:
      let
        pkgs = import inputs.nixpkgs
          {
            inherit system;
            overrides =
              let kubeseal_override = _: super: {
                kubeseal = super.kubeseal.overrideAttrs (_: rec {
                  version = "0.17.1";
                  src = inputs.kubeseal-src;
                });
              }; in [ kubeseal_override ];
          };
      in
      {
        packages.homeConfigurations."${username}" = inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home.nix
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
            {
              home = {
                inherit username;
                homeDirectory = "/home/${username}";
                stateVersion = "22.11";
              };
            }
          ];
        };
      });
}
