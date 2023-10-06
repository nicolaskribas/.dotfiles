local opt = vim.opt
opt.tabstop = 4
opt.shiftwidth = 0
opt.shiftround = true
opt.number = true
opt.signcolumn = "yes"
-- opt.fillchars = "eob: "
opt.mouse = "a"
opt.undofile = true
opt.ignorecase = true
opt.smartcase = true
-- opt.infercase = true
-- opt.cindent = true
opt.wrap = false
opt.linebreak = true -- use 'breakat' for determine when to wrap
-- opt.breakindent = true
opt.virtualedit = "block" -- allow the placing cursor where no character exist when in visual block
opt.termguicolors = true
-- opt.scrolloff = 5
-- opt.sidescrolloff = 10
opt.pumheight = 10
-- opt.completeopt = { "menuone", "noinsert", "noselect" }
opt.splitbelow = true
opt.splitright = true
-- opt.cursorline = true
-- opt.colorcolumn = "81"
-- opt.guicursor:append "a:blinkwait1-blinkon500-blinkoff500"
-- opt.diffopt:append { "indent-heuristic", "algorithm:histogram" }
opt.path:append "**"
--
vim.g.mapleader = " "
vim.diagnostic.config {
	virtual_text = false,
	--severity_sort = true,
}

local map = vim.keymap.set

-- disable space, it is the leader key
map("", "<Space>", "<NOP>")
--
-- -- use system clipboard
-- map({ "n", "x" }, "<leader>y", '"+y')
-- map({ "n", "x" }, "<leader>p", '"+p')
--
-- -- dealing with word wrap
-- map({ "n", "x" }, "k", [[v:count == 0 ? "gk" : "k"]], { expr = true })
-- map({ "n", "x" }, "j", [[v:count == 0 ? "gj" : "j"]], { expr = true })
--

map("n", "<Leader>d", vim.diagnostic.open_float)
map("n", "[d", vim.diagnostic.goto_prev)
map("n", "]d", vim.diagnostic.goto_next)
--
-- -- highlight on yank
-- local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
-- vim.api.nvim_create_autocmd("TextYankPost", {
-- 	callback = function()
-- 		vim.highlight.on_yank()
-- 	end,
-- 	group = highlight_group,
-- 	pattern = "*",
-- })
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local opts = { buffer = args.buf }
		local lsp = vim.lsp.buf
		map("n", "K", lsp.hover, opts)
		map("i", "<C-s>", lsp.signature_help, opts)
	end,
})

local lspconfig = require "lspconfig"
lspconfig.rust_analyzer.setup {}
lspconfig.clangd.setup {}
lspconfig.pylsp.setup {}
-- lspconfig.ltex.setup {}
-- lspconfig.texlab.setup {}

require("nvim-treesitter.configs").setup {
	ensure_installed = { "rust", "c" },
	parser_install_dir = vim.fn.stdpath "data" .. "/site",
	highlight = { enable = true },
	indent = { enable = true },
}
