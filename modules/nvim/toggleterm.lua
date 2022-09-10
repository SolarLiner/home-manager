require'toggleterm'.setup {
  insert_mappings = true,
}

vim.keymap.set({"n","i"}, "<c-ù>", "<cmd>:ToggleTerm direction=float<cr>")
vim.keymap.set({"n","i"}, "<c-²>", "<cmd>:ToggleTerm direction=horizontal<cr>")
