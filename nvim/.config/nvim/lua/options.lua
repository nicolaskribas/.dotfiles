local opt = vim.opt

opt.tabstop = 4
opt.shiftwidth = 4
opt.smartindent = true
opt.shiftround = true
opt.number = true
opt.mouse = "a"
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.updatetime = 250
opt.signcolumn = "yes"
opt.wrap = false
opt.termguicolors = true
opt.cursorline = true
opt.scrolloff = 5
opt.sidescrolloff = 10
opt.pumheight = 10
opt.completeopt = { "menuone", "noselect" }
opt.shortmess:append "c"
opt.guicursor:append "a:blinkwait1-blinkon500-blinkoff500"

vim.g.mapleader = " "
