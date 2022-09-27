require'telescope'.setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-h>"] = "which_key"
      }
    }
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  extensions = {
    -- Your extension configuration goes here:
    -- extension_name = {
    --   extension_config_key = value,
    -- }
    -- please take a look at the readme of the extension you want to configure
  }
}

local t = require 'telescope.builtin'
vim.keymap.set({'n','i'}, '<C-p>', t.find_files)
vim.keymap.set({'n','i'}, '<C,t>', t.lsp_workspace_symbols)

vim.keymap.set('n', '<leader>gd', t.lsp_definitions)
vim.keymap.set('n', '<leader>gy', t.lsp_type_definitions)
vim.keymap.set('n', '<leader>ff', t.find_files)
vim.keymap.set('n', '<leader>fg', t.live_grep)
vim.keymap.set('n', '<leader>fb', t.buffers)
vim.keymap.set('n', '<leader>fd', t.diagnostics)
vim.keymap.set('n', '<leader>fh', t.help_tags)
