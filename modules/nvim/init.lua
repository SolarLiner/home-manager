local opt = vim.opt
local g = vim.g

-- GUI font

opt.guifont = "Iosevka:h10"

-- Undo files
opt.undofile = true
opt.undodir = vim.fn.expand("~/.cache/neovim")

-- Indentation
opt.smartindent = true
opt.autoindent = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

-- Clipboard
opt.clipboard = "unnamedplus"

-- Mouse
opt.mouse = "a"

-- UI settings
opt.termguicolors = true
opt.cursorline = true
opt.number = true

-- No viminfo file
opt.viminfo = ""
opt.viminfofile = "NONE"

-- Misc
opt.lazyredraw = true
opt.showmatch = true
opt.smartcase = true
opt.timeoutlen = 5000
opt.autoread = true
opt.incsearch = true
opt.hidden = true
opt.shortmess = "atI"
opt.updatetime = 5000

g.mapleader = ' '
g.maplocalleader = ' '

vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('highlight_yank', { clear = false }),
  desc = 'Hightlight selection on yank',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'IncSearch', timeout = 500 }
  end,
})
