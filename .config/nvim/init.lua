local opt = vim.opt

opt.tabstop = 4
opt.shiftwidth = 0
opt.shiftround = true
opt.number = true
opt.signcolumn = "yes"
opt.mouse = "a"
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.wrap = false
opt.termguicolors = true
opt.scrolloff = 5
opt.sidescrolloff = 10
opt.pumheight = 10
opt.splitbelow = true
opt.splitright = true
opt.cursorline = true
opt.guicursor:append "a:blinkwait1-blinkon500-blinkoff500"
opt.diffopt:append { "indent-heuristic", "algorithm:histogram" }

vim.g.mapleader = " "
vim.diagnostic.config {
	virtual_text = false,
	severity_sort = true,
}
