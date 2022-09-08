{ pkgs, inputs, packages, ... }:
{
  home.packages = with pkgs; [
    # Utilities
    dapr-cli
    diesel-cli
    docker-compose
    tree
    # jq
    cachix
    ripgrep
    htop
    neofetch
    pv
    # Language tooling
    coq
    mold
    nixfmt
    packages.deno
    docker-compose
    pulumi-bin
    ## LSP
    rust-analyzer
    omnisharp-roslyn
    rnix-lsp
    nodePackages.diagnostic-languageserver
    nodePackages.eslint
    nodePackages.eslint_d
    nodePackages.pyright
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted
    sumneko-lua-language-server
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
    envFile = {
      text = ''
        mkdir ~/.cache/starship
        starship init nu | save ~/.cache/starship/init.nu
      '';
    };
    configFile = {
      text = ''
        source ~/.cache/starship/init.nu
      '';
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
      export CARGO_HOME=$HOME/.local/share/cargo
      if [[ -e $CARGO_HOME ]]; then
        export PATH=$CARGO_HOME/bin:$PATH
      fi

      # Pyenv
      export PYENV_ROOT=$HOME/.local/share/pyenv
      if [[ ! -e $PYENV_ROOT ]]; then
        git clone https://github.com/pyenv/pyenv.git $PYENV_ROOT
      else
        export PATH=$PYENV_ROOT/bin:$PATH
        eval "$(pyenv init --path)"
        # eval "$(pyenv virtualenv-init -)"
      fi

      # Dotnet
      # if [[ -e $HOME/.dotnet ]]; then
      #   export PATH=$HOME/.dotnet/tools:$PATH
      # fi
    '';
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" "pyenv" "nvm" "rust" "autojump" "vscode" ];
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
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    extraConfig = ''
      luafile ${./nvim/init.lua}
      luafile ${./nvim/tree-sitter.lua}

      lua << EOF
      vim.defer_fn(function()
        vim.cmd [[
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
      {
        plugin = nvim-autopairs;
        config = "lua require'nvim-autopairs'.setup{}";
      }
      # Colortheme
      material-nvim
      indentLine
      # Filetypes
      (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars))
      vim-nix
      # LSP
      nvim-lspconfig
      nvim-compe
      # UI
      nvim-web-devicons
      nvim-tree-lua
      popup-nvim
      plenary-nvim
      telescope-nvim
      bufferline-nvim
      lualine-nvim
      toggleterm-nvim

      # Neorg
      neorg
    ];
  };

  home.file.".ideavimrc".text = ''
    set clipboard=unnamedplus
    set clipboard+=ideaput
    set command
    set easymotion
    set highlightedyank
    set surround
  '';
  xdg.configFile."cargo/config".text = ''
    [target.x86_64-unknown-linux-gnu]
    linker="clang"
    rustflags = [
        "-C", "link-arg=-fuse-ld=${pkgs.mold}/bin/mold",
    ]
  '';
  # xdg.configFile."nvim/init.lua".source = ./nvim/init.lua;
  xdg.configFile."kitty/kitty.conf".text =
    let
      theme = builtins.fetchurl {
        url = "https://raw.githubusercontent.com/kdrag0n/base16-kitty/master/colors/base16-material-darker.conf";
        sha256 = "sha256:01rmlpgclvhimr92f0v95301dz73iakgr61zcifcia6054yj12fd";
      };
      # theme = "${packages.nvim-github-theme}/terminal/kitty/github_dark.conf";
    in
    ''
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
  xdg.configFile."environment.d/99-extra-path.conf".source = ./environment.d/99-extra-path.conf;
}
