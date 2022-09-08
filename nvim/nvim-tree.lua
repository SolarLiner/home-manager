require'nvim-tree'.setup {
  open_on_setup = true,
  open_on_tab = true,
  system_open = {
    cmd = "xdg-open",
  },
  diagnostics = {
    enable = true,
  },
  git = {
    enable = true,
    ignore = false,
  },
    filters = {
        custom = {
            [[\\.git]],
            [[node_modules]]
        },
    },
  renderer = {
    special_files = {
      "LICENSE",
      "README.md",
      "Cargo.toml",
      "Makefile",
    },
    view = {
      adaptive_size = true,
    },
  },
}

vim.api.nvim_set_keymap('n', '<C-b>', ':NvimTreeToggle<CR>', {})
vim.api.nvim_set_keymap('i', '<C-b>', ':NvimTreeToggle<CR>', {})
