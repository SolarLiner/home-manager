{ pkgs, ... }:
let
  nixGLrepo = import "${(builtins.fetchTarball "https://github.com/guibou/nixGL/archive/master.tar.gz")}/nixGL.nix";
  nixGL = pkgs.callPackage nixGLrepo {};
  extraPkgs = import ./pkgs.nix {};
  flatten = set: with pkgs.lib; let
    isNameValue = v: with builtins; hasAttr "name" v && hasAttr "value" v;
    attrs = attrsets.mapAttrsRecursive (
      path: attrsets.nameValuePair (strings.concatStrings (strings.intersperse "." path))
    );
    valsDeep = attrsets.collect isNameValue (attrs set);
    vals = lists.flatten valsDeep;
  in
    builtins.listToAttrs vals;
  tidal =
    pkgs.stdenvNoCC.mkDerivation
      {
        pname = "tidal";
        version = "master";
        src = pkgs.fetchFromGitHub {
          repo = "vim-tidal";
          owner = "tidalcycles";
          rev = "master";
          sha256 = "sha256-zR3DQU3PpfTEz2rXOaOHd2Q2T7V8KQpiiAod0tECSlw=";
        };
        nativeBuildInputs = with pkgs; [ coreutils ];
        phases = [ "unpackPhase" "installPhase" ];
        installPhase = ''
          mkdir -p $out/bin
          ln -s $src/bin/tidal $out/bin
        '';
      };
in
{
  home.packages = with pkgs; [
    # tidal
    coq
    tree
    cachix
    htop
    # ffmpeg
    docker-compose
    # neofetch
    jq
    nixfmt
    # julia
    # flamegraph
    pv
    # radare2
    # rust-analyzer
    # ruby
    # faust2
    # faustlive
    /* (
      agda.withPackages
        (p: with p; [ standard-library ])
    ) */
    # idris2
    # meson
    # ninja
    # flatpak
    # flatpak-builder
    # niv
    rnix-lsp
    pulumi-bin
    # coq
    # ghc
    # cabal-install
    # haskell-language-server
    # Fonts
    jetbrains-mono
  ];

  fonts.fontconfig.enable = true;

  programs.home-manager.enable = true;
  programs.autojump.enable = true;
  programs.bat.enable = true;
  programs.bash.enable = false;
  programs.nushell = {
    enable = true;
    settings = {
      startup = [
        "mkdir ~/.cache/starship"
        "starship init nu | save ~/.cache/starship/init.nu"
        "source ~/.cache/starship/init.nu"
      ];
      prompt = "starship_prompt";
    };
  };
  programs.exa = {
    enable = true;
    enableAliases = true;
  };
  programs.git = {
    package = pkgs.gitAndTools.gitFull;
    enable = true;
    delta.enable = true;
    lfs.enable = true;
    userName = "Nathan Graule";
    userEmail = "solarliner@gmail.com";
  };
  programs.gh = {
    enable = true;
    settings = {
      prompt = "enabled";
      git_protocol = "ssh";
    };
  };
  programs.opam = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableAutosuggestions = true;
    enableSyntaxHighlighting = true;
    sessionVariables = {
      EDITOR = "nvim";
    };
    plugins = extraPkgs.zsh-plugins;
    initExtra = ''
      if [ -e $HOME/.profile ]; then
        . $HOME/.profile
      fi

      # NVM
      export NVM_DIR=$HOME/.local/share/nvm
      if [[ ! -e $NVM_DIR ]]; then
        git clone https://github.com/nvm-sh/nvm.git $NVM_DIR
      fi
      source $NVM_DIR/nvm.sh
      source $NVM_DIR/bash_completion

      # Rustup
      export CARGO_HOME=$HOME/.cargo
      if [[ ! -e $CARGO_HOME ]]; then
        export PATH=$CARGO_HOME/bin:$PATH
      fi
    '';
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" "pyenv" "nvm" "cargo" "rust" "autojump" "vscode" ];
      extraConfig = ''
        BULLETTRAIN_PROMPT_ORDER=(
        git
        context
        dir
        virtualenv
        nvm
        go
        )
        BULLETTRAIN_VIRTUALENV_FG=black
        BULLETTRAIN_NVM_FG=black
        BULLETTRAIN_CONTEXT_DEFAULT_USER=solarliner
        BULLETTRAIN_CONTEXT_IS_SSH_CLIENT=true
        BULLETTRAIN_DIR_EXTENDED=0
        BULLETTRAIN_DIR_BG=black
        BULLETTRAIN_DIR_FG=white

        export NIX_PATH=$HOME/.nix-defexpr/channels''${NIX_PATH:+:}$NIX_PATH
      '';
    };
  };
  programs.neovim = {
    enable = true;
    withNodeJs = true;
    withPython3 = true;
    extraConfig = ''
      set nocompatible
      set nobackup
      set clipboard=unnamedplus
      set mouse=a

      set relativenumber
      set expandtab
      set softtabstop=4
      set tabstop=4
      set shiftwidth=4

      set updatetime=300

      let mapleader = ','
      let maplocalleader = ','

      set exrc
      set secure
      autocmd InsertEnter * :set number
      autocmd InsertLeave * :set relativenumber

      if (has("nvim"))
      let $NVIM_TUI_ENABLE_TRUE_COLOR=1
      endif
      if (has("termguicolors"))
      set termguicolors
      endif

      if has('nvim-0.5.0') || has('patch-8.1.1564')
        set signcolumn=number
      else
        set signcolumn=yes
      endif

      " Custom Vim keybinds
      nnoremap <S-Tab> <<
      vnoremap <S-Tab> <
      inoremap <S-Tab> <C-d>
      nnoremap <Tab> >>
      vnoremap <Tab> >
    '';

    plugins = with pkgs.vimPlugins; [
      {
        plugin = pkgs.vimUtils.buildVimPluginFrom2Nix {
          pname = "material.vim";
          version = "main";
          src = pkgs.fetchFromGitHub {
            owner = "kaicataldo";
            repo = "material.vim";
            rev = "main";
            sha256 = "sha256:1wi1brm1yml4xw0zpc6q5y0ql145v1hw5rbbcsgafagsipiz4av3";
          };
        };
        config = ''
          set background = "dark"
          let g:material_theme_style = 'darker'
          let g:material_theme_italics = 1
          colorscheme material
        '';
      }
      {
        plugin = airline;
        config = ''
          let g:airline_theme = 'material'
          let g:airline#extensions#tabline#enabled = 1
          let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
          let g:airline_powerline_fonts = 1
        '';
      }
      ctrlp
      vim-toml
      vim-nix
      vim-sensible
      vim-surround
      fzf-vim
      emmet-vim
      vim-sleuth
      vim-javascript
      typescript-vim
      {
        plugin = coc-nvim;
        config = ''
          inoremap <silent><expr> <TAB>
          \ pumvisible() ? coc#_select_confirm() :
          \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump','''])\<CR>" :
          \ <SID>check_back_space() ? "\<TAB>" :
          \ coc#refresh()

          function! s:check_back_space() abort
          let col = col('.') - 1
          return !col || getline('.')[col - 1]  =~# '\s'
          endfunction

          let g:coc_snippet_next = '<tab>'
          let g:coc_snippet_prev = '<s-tab>'

          " Highlight symbol under cursor on CursorHold
          autocmd CursorHold * silent! call CocActionAsync('highlight')

          " Remap for rename current word
          nmap <leader>rn <Plug>(coc-rename)

          " Remap for hover action
          nmap <leader>h :call CocAction('doHover')<CR>

          " Remap for format selected region
          xmap <leader>f  <Plug>(coc-format-selected)
          nmap <leader>f  <Plug>(coc-format)

          " Remap keys for gotos
          nmap <silent> gd <Plug>(coc-definition)
          nmap <silent> gy <Plug>(coc-type-definition)
          nmap <silent> gi <Plug>(coc-implementation)
          nmap <silent> gr <Plug>(coc-references)

          " Remap for do codeAction of current line
          nmap <leader>ac  <Plug>(coc-codeaction)
          " Fix autofix problem of current line
          nmap <leader>fc  <Plug>(coc-fix-current)

          " Search workspace symbols
          nmap <leader>s :<C-u>CocList -I symbols<cr>

          " Add status line support, for integration with other plugin, checkout `:h coc-status`
          set statusline^=%{coc#status()}%{get(b:,'coc_current_function',''')}

          " Add comments to JSON
          autocmd FileType json syntax match Comment +\/\/.\+$+

          " use <c-space>for trigger completion
          inoremap <silent><expr> <c-space> coc#refresh()
        '';
      }
      {
        plugin = editorconfig-vim;
        config = ''let g:EditorConfig_exclude_patterns = ["fugitive://.\*"]'';
      }
      coc-rust-analyzer
      coc-git
      coc-python
      coc-clangd
      coc-tsserver
      coc-json
      coc-yaml
      coc-html
      coc-vimlsp
      {
        plugin = Coqtail;
        config = ''
          augroup CoqtailHighlights
            autocmd!
            autocmd ColorScheme *
              \  hi def CoqtailChecked guibg=DarkGreen guifg=White
              \| hi def CoqtailSent    guibg=DarkBlue  guifg=White
          augroup END
          augroup CoqtailEnable
            autocmd FileType *.v CoqStart
          augroup END
          '';
        # config = ''
        # augroup CoqtailHighlights
        # autocmd!
        # autocmd ColorScheme *
        # \  hi def CoqtailChecked ctermbg = 4
        #   \| hi def CoqtailSent ctermbg=7
        # augroup END'';
      }
      agda-vim
      fugitive
      idris2-vim
      auto-pairs
      zig-vim
      nerdtree
      nerdtree-git-plugin
    ] ++ extraPkgs.vim-plugins;

    extraPackages = with pkgs; [ fzf ];
    extraPython3Packages = ps: with ps; [ /* python-language-server */ ];
  };
  programs.vscode = {
    enable = false;
    package = (
      pkgs.writeScriptBin "code.sh" ''
        #!/usr/bin/env bash
              code $@
      ''
    ).overrideAttrs (s: s // (pkgs.lib.attrsets.getAttrs [ "pname" "version" "name" ] pkgs.vscode));
    extensions = with pkgs.vscode-extensions; [
      bbenoist.Nix
      haskell.haskell
      ms-python.python
      ms-python.vscode-pylance
      ms-vscode-remote.remote-ssh
      ocamllabs.ocaml-platform
      dhall.dhall-lang
      vscodevim.vim
      jnoortheen.nix-ide
      tamasfe.even-better-toml
    ] ++ extraPkgs.vscode-extensions;
    userSettings = flatten {
      update.mode = "none";
      editor = {
        formatOnSave = true;
        formatOnPaste = true;
        minimap.renderCharacters = false;
        fontFamily = "'JetBrains Mono'";
      };
      git = {
        enableSmartCommit = true;
        autofetch = true;
      };
      licenser = {
        author = "Nathan Graule";
        license = "MIT";
      };
      files.autoSave = "onFocusChange";
      nix.enableLanguageServer = true;
      window = {
        menuBarVisibility = "compact";
        titleBarStyle = "custom";
      };
      workbench = {
        colorTheme = "Material Theme Darker High Contrast";
        iconTheme = "eq-material-theme-icons-darker";
      };
    };
  };

  xdg.configFile."nvim/coc-settings.json".text = builtins.toJSON {
    languageserver = {
      haskell = {
        command = "haskell-language-server-wrapper";
        filetypes = [ "hs" "lhs" "haskell" ];
        rootPatterns = [ "stack.yml" "cabal.config" "package.yaml" ];
        initializationOptions = {
          languageServerHaskell = {
            hlintOn = true;
          };
        };
      };
      nix = {
        command = "rnix-lsp";
        filetypes = [ "nix" ];
      };
      python = {
        command = "python-language-server";
        filetypes = [ "py" ];
        rootPatterns = [ "pyproject.toml" "setup.py" "setup.cfg" ];
      };
      ocaml = { command = "ocamllsp"; filetypes = [ "ml" "ocaml" ]; rootPatterns = [ "dune-project" "dune-workspace" ".git" ]; };
      zig = {
        command = "zls";
        filetypes = [ "zig" ];
        rootPatterns = [ "builg.zig" ];
      };
    };
    "eslint.format.enable" = true;
    "rust-analyzer.server.path" = "${pkgs.rust-analyzer}/bin/rust-analyzer";
    "rust-analyzer.procMacro.enable" = true;
    "rust-analyzer.cargo.loadOutDirsFromCheck" = true;
  };
  #  // (
  #   flatten {
  #   rust-analyzer = {
  #     # path = "${pkgs.rust-analyzer}/bin/rust-analyzer";
  #     path = "rust-analyzer";
  #     procMacro.enable = true;
  #     cargo.loadOutDirsFromCheck = true;
  #   };
  #  }
  #  );
}
