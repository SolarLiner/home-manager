{ pkgs, inputs, packages, ... }:
{
  home.packages = with pkgs; [
    # tidal
    coq
    tree
    cachix
    htop
    # dotnet-sdk_6
    packages.deno
    # ffmpeg
    docker-compose
    # neofetch
    jq
    nixfmt
    # julia
    # flamegraph
    pv
    # radare2
    rust-analyzer
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
    plugins = [ packages.zsh-256color ];
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
      if [[ -e $CARGO_HOME ]]; then
        export PATH=$CARGO_HOME/bin:$PATH
      fi

      # Pyenv
      export PYENV_ROOT=$HOME/.pyenv
      if [[ -e $PYENV_ROOT ]]; then
        export PATH=$PYENV_ROOT/bin:$PATH
        eval "$(pyenv init --path)"
        eval "$(pyenv virtualenv-init -)"
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
      set hidden
      set list
      set listchars=tab:↦\ ,trail:⬝
      set clipboard=unnamedplus
      set mouse=a
      set signcolumn=yes:2

      set relativenumber
      set expandtab
      set softtabstop=4
      set tabstop=4
      set shiftwidth=4

      set wildmenu
      set wildmode=longest:full,full
      set scrolloff=8
      set sidescrolloff=8

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
      vnoremap < <gv
      vnoremap > >gv
      nnoremap <S-Tab> <<
      vnoremap <S-Tab> <gv
      inoremap <S-Tab> <C-d>
      nnoremap <Tab> >>
      vnoremap <Tab> >gv

      " Open files highlithed under cursor
      map gf :edit <cfile><cr>
    '';

    plugins = with pkgs.vimPlugins; [
      {
        plugin = packages.vim-autosave;
        config = ''
          let g:auto_save = 1  " enable AutoSave on Vim startup
          '';
      }
      {
        plugin = packages.material-vim;
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
      vim-polyglot
      typescript-vim
      agda-vim
      fugitive
      idris2-vim
      auto-pairs
      zig-vim
      nerdtree
      nerdtree-git-plugin
      vim-devicons
      popup-nvim
      markdown-preview-nvim
      {
        plugin = editorconfig-vim;
        config = ''let g:EditorConfig_exclude_patterns = ["fugitive://.\*"]'';
      }
      {
        plugin = nvim-lspconfig;
        config = ''
          lua << EOF
          ${builtins.readFile ./nvim/lspconfig.lua}
          EOF
          '';
      }
      { 
        plugin = nvim-cmp;
        config = ''
          lua << EOF
          ${builtins.readFile ./nvim/cmp.lua}
          EOF
          '';
      }
      # {
      #   plugin = coc-nvim;
      #   config = ''
      #     inoremap <silent><expr> <TAB>
      #     \ pumvisible() ? coc#_select_confirm() :
      #     \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump','''])\<CR>" :
      #     \ <SID>check_back_space() ? "\<TAB>" :
      #     \ coc#refresh()
      # 
      #     function! s:check_back_space() abort
      #     let col = col('.') - 1
      #     return !col || getline('.')[col - 1]  =~# '\s'
      #     endfunction
      # 
      #     let g:coc_snippet_next = '<tab>'
      #     let g:coc_snippet_prev = '<s-tab>'
      # 
      #     " Highlight symbol under cursor on CursorHold
      #     autocmd CursorHold * silent! call CocActionAsync('highlight')
      # 
      #     " Remap for rename current word
      #     nmap <leader>rn <Plug>(coc-rename)
      # 
      #     " Remap for hover action
      #     nmap <leader>h :call CocAction('doHover')<CR>
      # 
      #     " Remap for format selected region
      #     xmap <leader>f  <Plug>(coc-format-selected)
      #     nmap <leader>f  <Plug>(coc-format)
      # 
      #     " Remap keys for gotos
      #     nmap <silent> gd <Plug>(coc-definition)
      #     nmap <silent> gy <Plug>(coc-type-definition)
      #     nmap <silent> gi <Plug>(coc-implementation)
      #     nmap <silent> gr <Plug>(coc-references)
      # 
      #     " Remap for do codeAction of current line
      #     nmap <leader>ac  <Plug>(coc-codeaction)
      #     " Fix autofix problem of current line
      #     nmap <leader>fc  <Plug>(coc-fix-current)
      # 
      #     " Search workspace symbols
      #     nmap <leader>s :<C-u>CocList -I symbols<cr>
      # 
      #     " Add status line support, for integration with other plugin, checkout `:h coc-status`
      #     set statusline^=%{coc#status()}%{get(b:,'coc_current_function',''')}
      # 
      #     " Add comments to JSON
      #     autocmd FileType json syntax match Comment +\/\/.\+$+
      # 
      #     " use <c-space>for trigger completion
      #     inoremap <silent><expr> <c-space> coc#refresh()
      #   '';
      # }
      # coc-rust-analyzer
      # coc-git
      # coc-python
      # coc-clangd
      # coc-tsserver
      # coc-omnisharp
      # coc-json
      # coc-yaml
      # coc-html
      # coc-vimlsp
      # {
      #   plugin = Coqtail;
      #   config = ''
      #     augroup CoqtailHighlights
      #       autocmd!
      #       autocmd ColorScheme *
      #         \  hi def CoqtailChecked guibg=DarkGreen guifg=White
      #         \| hi def CoqtailSent    guibg=DarkBlue  guifg=White
      #     augroup END
      #     augroup CoqtailEnable
      #       autocmd FileType *.v CoqStart
      #     augroup END
      #   '';
      #   # config = ''
      #   # augroup CoqtailHighlights
      #   # autocmd!
      #   # autocmd ColorScheme *
      #   # \  hi def CoqtailChecked ctermbg = 4
      #   #   \| hi def CoqtailSent ctermbg=7
      #   # augroup END'';
      # }
    ];

    extraPackages = with pkgs; [ fzf ];
    extraPython3Packages = ps: with ps; [ /* python-language-server */ ];
  };

  home.file.".ideavimrc".text = ''
    set clipboard=ideaput
    set command
    set easymotion
    set highlightedyank
    set surround
  '';
  xdg.configFile."kitty/kitty.conf".text =
    let theme = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/kdrag0n/base16-kitty/master/colors/base16-material-darker.conf";
      sha256 = "sha256:01rmlpgclvhimr92f0v95301dz73iakgr61zcifcia6054yj12fd";
    }; in ''
    font_family JetBrains Mono
    font_size 10
    adjust_line_height 130%
    disable_ligatures cursor
    enable_audio_bell no
    visual_bell_duration 0.1
    window_margin_width 8
    tab_bar_style powerline

    include ${theme}
  '';
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
