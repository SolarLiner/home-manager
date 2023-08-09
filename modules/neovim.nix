{ pkgs, ... }:
let
  clangd = pkgs.stdenv.mkDerivation rec {
    pname = "clangd";
    version = "15.0.6";
    src = pkgs.fetchzip {
      url = "https://github.com/clangd/clangd/releases/download/${version}/clangd-linux-${version}.zip";
      sha256 = "sha256-5z2Iud+a/9SbOzsdbJOfdAqmv7U4MLSeC4oxPXJh/qc=";
    };
    phases = ["installPhase"];
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
    version = "0.6.2";
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
    slint-lsp
  ];
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraConfig = ''
      luafile ${./nvim/init.lua}
      luafile ${./nvim/tree-sitter.lua}

      lua << EOF
      vim.defer_fn(function()
      vim.cmd [[
        luafile ${./nvim/cmp.lua}
        luafile ${./nvim/lspconfig.lua}
        luafile ${./nvim/bufferline.lua}
        luafile ${./nvim/lualine.lua}
        luafile ${./nvim/neorg.lua}
        luafile ${./nvim/nvim-tree.lua}
        luafile ${./nvim/toggleterm.lua}
        luafile ${./nvim/telescope.lua}
      ]]
      end, 70)
      EOF
    '';
    plugins = with pkgs.vimPlugins; [
      vim-surround
      indentLine
      luasnip
      {
        plugin = nvim-autopairs;
        config = "lua require'nvim-autopairs'.setup{}";
      }
      {
        plugin = vim-auto-save;
        config = ''
          let g:auto_save = 1
          let g:auto_save_silent = 1
          let g:auto_save_events = ["InsertLeave", "TextChanged"]
        '';
      }
      nvim-web-tools

      # Colortheme
      material-nvim

      # Filetypes
      (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars ++ [ tree-sitter-wgsl ]))
      vim-nix
      vim-glsl

      # LSP
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-nvim-lsp-document-symbol
      cmp-nvim-lsp-signature-help
      cmp_luasnip
      lspkind-nvim

      # UI
      {
        plugin = dressing-nvim;
        config = "lua require'dressing'.setup {}";
      }
      nvim-web-devicons
      nvim-tree-lua
      popup-nvim
      plenary-nvim
      telescope-nvim
      bufferline-nvim
      lualine-nvim
      toggleterm-nvim

      # Neorg
      #neorg
    ];
  };
  programs.zsh = {
    sessionVariables = {
      EDITOR = "nvim";
    };
  };
}
