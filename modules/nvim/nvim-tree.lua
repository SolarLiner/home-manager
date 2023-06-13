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
  },
}

vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', {})
