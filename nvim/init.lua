local opt = vim.opt
local g = vim.g

-- Color scheme
g.material_style = 'darker'
require'material'.setup {}
vim.cmd 'colorscheme material'

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

g.mapleader = ' '
g.maplocalleader = ' '
