vim.opt.guicursor = ""

vim.opt.nu = true 
vim.opt.relativenumber = true

vim.opt.tabstop = 4 
vim.opt.softtabstop = 4 
vim.opt.shiftwidth = 4

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = false

vim.opt.hlsearch = false
vim.opt.incsearch = true 

vim.opt.termguicolors = true

vim.opt.updatetime = 50
vim.opt.scrolloff = 8

vim.opt.colorcolumn = "80"

vim.cmd([[ au TextYankPost * silent! lua vim.highlight.on_yank() ]])
