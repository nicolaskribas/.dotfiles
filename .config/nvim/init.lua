local opt = vim.opt
opt.tabstop = 4
opt.shiftwidth = 0
opt.shiftround = true
opt.number = true
opt.signcolumn = "yes"
opt.fillchars = "eob: "
opt.mouse = "a"
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
opt.infercase = true
opt.cindent = true
opt.wrap = false
opt.linebreak = true
opt.breakindent = true
opt.virtualedit = "block"
opt.termguicolors = true
opt.scrolloff = 5
opt.sidescrolloff = 10
opt.pumheight = 10
opt.completeopt = { "menuone", "noinsert", "noselect" }
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

local map = vim.keymap.set

-- disable space, it is the leader key
map("", "<Space>", "<Nop>")

-- use system clipboard
map({ "n", "x" }, "<leader>y", '"+y')
map({ "n", "x" }, "<leader>p", '"+p')

-- dealing with word wrap
map({ "n", "x" }, "k", [[v:count == 0 ? "gk" : "k"]], { expr = true })
map({ "n", "x" }, "j", [[v:count == 0 ? "gj" : "j"]], { expr = true })

-- diagnostics
map("n", "<leader>d", vim.diagnostic.open_float)
map("n", "[d", vim.diagnostic.goto_prev)
map("n", "]d", vim.diagnostic.goto_next)

-- highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system {
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	}
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup "plugins"
