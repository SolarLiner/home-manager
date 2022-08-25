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
    deno.url = path:./packages/deno;
    deno.inputs.nixpkgs.follows = "nixpkgs";
    zsh-256color = {
      url = github:chrissicool/zsh-256color;
      flake = false;
    };
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
        packages = {
          inherit (inputs.deno.packages.${system}) deno;
          zsh-256color = rec {
            name = "zsh-256color";
            file = "${name}.plugin.zsh";
            src = inputs.zsh-256color;
          };
        };
        packages.homeConfigurations."${username}" = inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          extraSpecialArgs = { inherit inputs; packages = inputs.self.packages."${system}"; };
          modules = [
            ./home.nix
            { home = {
              inherit username;
              homeDirectory = "/home/${username}";
              stateVersion = "22.05";
            }; }
          ];
        };
      });
}
