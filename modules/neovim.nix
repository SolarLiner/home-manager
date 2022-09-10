{ pkgs, ... }:
let
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
    name = "utilsnips";
    src = pkgs.fetchFromGitHub {
      repo = "utilsnips";
      owner = "SirVer";
      rev = "a289af77e14d224ab9770f9802d090f176dd340f";
      sha256 = "";
    };
  };
  wgsl-analyzer = pkgs.rustPlatform.buildRustPackage rec {
    pname = "wgsl-analyzer";
    version = "0.5.0";
    src = pkgs.fetchFromGitHub {
      owner = "wgsl-analyzer";
      repo = pname;
      rev = "v${version}";
      sha256 = "fC5yGhhrFfn4ieIWYr5fQprTMsxT6/vtN2FmzZjoqKE=";
    };
    cargoSha256 = "";
  }; 
in {
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
    # wgsl-analyzer
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
        let g:auto_save_events = ["InsertLeave", "CursorHold"]
        '';
      }
      nvim-web-tools

      # Colortheme
      material-nvim

      # Filetypes
      (nvim-treesitter.withPlugins (plugins: pkgs.tree-sitter.allGrammars))
      vim-nix

      # LSP
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      cmp-nvim-lsp-document-symbol
      cmp-nvim-lsp-signature-help
      cmp_luasnip

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
      neorg
    ];
  };
  programs.zsh = {
    sessionVariables = {
      EDITOR = "nvim";
    };
  };
}
