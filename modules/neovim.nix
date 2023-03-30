{ lib, pkgs, astronvimPath ? builtins.toPath ./astronvim, ... }:
let
  clangd = pkgs.stdenv.mkDerivation rec {
    pname = "clangd";
    version = "15.0.1";
    src = pkgs.fetchzip {
      url = "https://github.com/clangd/clangd/releases/download/${version}/clangd-linux-${version}.zip";
      sha256 = "sha256-GJxu/h20sIG0cv7+0n2PzLkVF6NuZYjLzYt0TOVU4UY=";
    };
    phases = [ "installPhase" ];
    installPhase = ''
      cp -rv $src $out
    '';
  };
  nvim-web-tools = pkgs.vimUtils.buildVimPlugin {
    name = "web-tools";
    src = pkgs.fetchFromGitHub {
      repo = "web-tools.nvim";
      owner = "ray-x";
      rev = "a289af77e14d224ab9770f9802d090f176dd340f";
      sha256 = "0XUGe0XaPOB9VJ6ODa0dTs2D/Ks0dfX0I3H00Vnohv0=";
    };
  };
  utilsnips = pkgs.vimUtils.buildVimPlugin {
    pname = "utilsnips";
    src = pkgs.fetchFromGitHub {
      repo = "utilsnips";
      owner = "SirVer";
      rev = "a289af77e14d224ab9770f9802d090f176dd340f";
      sha256 = "";
    };
  };
  wgsl_analyzer = pkgs.stdenvNoCC.mkDerivation rec {
    pname = "wgsl_analyzer";
    version = "0.5.0";
    src = builtins.fetchurl {
      url = "https://github.com/wgsl-analyzer/wgsl-analyzer/releases/download/v${version}/wgsl_analyzer-linux-x64";
      sha256 = "1m0068c2c3v64d8wmxqnpf8l6nrw8s8k527psvyhxr4sglz0fw6l";
    };
    nativeBuildInputs = [ pkgs.autoPatchelfHook ];
    phases = [ "installPhase" ];
    installPhase = ''
      mkdir -p $out/bin
      pwd
      ls -a $src
      install -m755 -D $src $out/bin/${pname}
    '';
  };
  mkGrammar = with pkgs;
    {
      # language name
      language
      # version of tree-sitter
    , version
      # source for the language grammar
    , source
    , location ? null
    }:

    stdenv.mkDerivation rec {

      pname = "${language}-grammar";
      inherit version;

      src = if location == null then source else "${source}/${location}";

      buildInputs = [ tree-sitter ];

      dontUnpack = true;
      dontConfigure = true;

      CFLAGS = [ "-I${src}/src" "-O2" ];
      CXXFLAGS = [ "-I${src}/src" "-O2" ];

      stripDebugList = [ "parser" ];

      # When both scanner.{c,cc} exist, we should not link both since they may be the same but in
      # different languages. Just randomly prefer C++ if that happens.
      buildPhase = ''
        runHook preBuild
        if [[ -e "$src/src/scanner.cc" ]]; then
          $CXX -fPIC -c "$src/src/scanner.cc" -o scanner.o $CXXFLAGS
        elif [[ -e "$src/src/scanner.c" ]]; then
          $CC -fPIC -c "$src/src/scanner.c" -o scanner.o $CFLAGS
        fi
        $CC -fPIC -c "$src/src/parser.c" -o parser.o $CFLAGS
        $CXX -shared -o parser *.o
        runHook postBuild
      '';

      installPhase = ''
        runHook preInstall
        mkdir $out
        mv parser $out/
        if [[ -d "$src/queries" ]]; then
          cp -r $src/queries $out/
        fi
        runHook postInstall
      '';
    }
  ;
  tree-sitter-wgsl = mkGrammar {
    language = "wgsl";
    version = "master";
    source = pkgs.fetchFromGitHub {
      repo = "tree-sitter-wgsl";
      owner = "szebniok";
      rev = "272e89ef2aeac74178edb9db4a83c1ffef80a463";
      sha256 = "x42qHPwzv3uXVahHE9xYy3RkrYFctJGNEJmu6w1/2Qo=";
    };
  };
in
{
  home.packages = with pkgs; [
    nodePackages.browser-sync
    rust-analyzer
    rnix-lsp
    nodePackages.diagnostic-languageserver
    nodePackages.eslint
    nodePackages.eslint_d
    nodePackages.pyright
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
    sumneko-lua-language-server
    wgsl_analyzer
    clangd
  ];
  programs.zsh.initExtra = ''
    if [[ ! -e $HOME/.config/nvim ]]; then
      git clone --depth 1 https://github.com/AstroNvim/AstroNvim $HOME/.config/nvim
    fi
  '';
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    plugins = with pkgs.vimPlugins; [ (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars ++ [ tree-sitter-wgsl ])) ];
  };
  programs.zsh = {
    sessionVariables = {
      EDITOR = "nvim";
    };
  };
  home.activation = {
    astronvimUserConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      NVIM_CONFIG_HOME=$HOME/.config/nvim
      ASTRONVIM_USER_DIR=$NVIM_CONFIG_HOME/lua/user
      echo "Clearing astronvim user dir"
      $DRY_RUN_CMD rm -rf $VERBOSE_ARG $ASTRONVIM_USER_DIR
      echo "Creating link to astronvim user dir"
      $DRY_RUN_CMD ln -s $VERBOSE_ARG \
          ${astronvimPath} $ASTRONVIM_USER_DIR
    '';
  };
}
