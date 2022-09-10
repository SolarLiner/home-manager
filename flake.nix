{
  description = "Personal home-manager setup";
  inputs = rec {
    nixpkgs = {
      type = "indirect";
      id = "nixpkgs";
    };
    flake-utils.url = github:numtide/flake-utils;
    flake-utils.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = github:nix-community/home-manager;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs:
    let username = "solarliner"; in
    with inputs.flake-utils.lib; eachDefaultSystem (system:
      let
        pkgs = import inputs.nixpkgs {
          inherit system;
        };
      in
      {
        packages.homeConfigurations."${username}" = inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./home.nix
            ./modules/firefox.nix
            ./modules/jetbrains.nix
            ./modules/neovim.nix
            ./modules/node.nix
            ./modules/ocaml.nix
            ./modules/python.nix
            ./modules/rust.nix
            ./modules/shell.nix
            ./modules/terminal.nix
            { home = {
              inherit username;
              homeDirectory = "/home/${username}";
              stateVersion = "22.05";
            }; }
          ];
        };
      });
}
