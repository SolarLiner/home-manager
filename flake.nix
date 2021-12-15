{
  description = "Personal home-manager setup";
  inputs = rec {
    nixpkgs = {
      type = "indirect";
      id = "nixpkgs";
    };
    flake-utils.url = github:numtide/flake-utils;
    flake-utils.inputs = {
      inherit nixpkgs;
    };
    home-manager.url = github:nix-community/home-manager;
    home-manager.inputs = {
      inherit nixpkgs;
    };
    vim-autosave = {
      url = github:907th/vim-auto-save;
      flake = false;
    };
    material-vim = {
      url = github:kaicataldo/material.vim;
      flake = false;
    };
    nvim-lsp-installer = {
      url = github:williamboman/nvim-lsp-installer;
      flake = false;
    };
    coc-omnisharp = {
      url = github:coc-extensions/coc-omnisharp;
      flake = false;
    };
    deno = {
      url = https://github.com/denoland/deno/releases/download/v1.16.4/deno-x86_64-unknown-linux-gnu.zip;
      flake = false;
    };
    zsh-256color = {
      url = github:chrissicool/zsh-256color;
      flake = false;
    };
  };
  outputs = inputs:
  let username = "solarliner"; in
  with inputs.flake-utils.lib; eachDefaultSystem (system:
  let
  pkgs = import inputs.nixpkgs { inherit system; };
  in
  {
  packages = {
  deno = pkgs.stdenvNoCC.mkDerivation {
  pname = "deno";
  version = "1.16.4";
  src = inputs.deno;
  phases = [ "installPhase" ];
  dontUnpack = true;
  installPhase = ''
  mkdir -p $out/bin
  cp $src $out/bin
  '';
  };
  coc-omnisharp = pkgs.vimUtils.buildVimPluginFrom2Nix {
  pname = "coc-omnisharp";
  version = "master";
  src = inputs.coc-omnisharp;
  };
  material-vim = pkgs.vimUtils.buildVimPluginFrom2Nix {
  pname = "material.vim";
  version = "master";
  src = inputs.material-vim;
  };
  nvim-lsp-installer = pkgs.vimUtils.buildVimPluginFrom2Nix {
  pname = "nvim-lsp-installer";
  version = "master";
  src = inputs.nvim-lsp-installer;
  };
  vim-autosave = pkgs.vimUtils.buildVimPluginFrom2Nix {
  pname = "vim-autosave";
  version = "master";
  src = inputs.vim-autosave;
  };
  zsh-256color = rec {
  name = "zsh-256color";
  file = "${name}.plugin.zsh";
  src = inputs.zsh-256color;
  };
  };
  packages.homeConfigurations."${username}" = inputs.home-manager.lib.homeManagerConfiguration {
  inherit system username;
  homeDirectory = "/home/${username}";
  configuration.imports = [ ./home.nix ];
  extraSpecialArgs = { inherit inputs; packages = inputs.self.packages."${system}"; };
  };
  });
  }
