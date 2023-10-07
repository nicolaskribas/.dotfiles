local opt = vim.opt
-- opt.tabstop = 4
opt.shiftwidth = 0 -- 0 means: same value as 'tabstop'
opt.shiftround = true -- rount indent to multiples of 'shifwidth'
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
	severity_sort = true,
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

map("n", "[d", vim.diagnostic.goto_prev) -- *
map("n", "]d", vim.diagnostic.goto_next) -- *
map("n", "<Leader>d", vim.diagnostic.open_float)

-- highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank { on_visual = false }
	end,
	group = highlight_group,
	pattern = "*",
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local lsp = vim.lsp.buf
		local opts = { buffer = args.buf }
		map("n", "gd", lsp.definition, opts) -- **
		map("n", "gD", lsp.declaration, opts) -- **
		map("n", "gt", lsp.type_definition, opts) -- *
		map("n", "K", lsp.hover, opts) -- **
		map({ "n", "i" }, "<C-s>", lsp.signature_help, opts)
		map("n", "<Leader>s", lsp.rename, opts) -- 's' for subistitute
		map("n", "<Leader>r", lsp.references, opts)
		map("n", "<Leader>a", lsp.code_action, opts)
		map("n", "<Leader>x", lsp.document_symbol, opts)
		map("n", "<Leader>im", lsp.implementation, opts)
	end,
})

local lspconfig = require "lspconfig"
lspconfig.rust_analyzer.setup {}
lspconfig.clangd.setup {}
lspconfig.pylsp.setup {}
lspconfig.texlab.setup {
	settings = { texlab = {
		build = { onSave = true },
		chktex = { onOpenAndSave = true, onEdit = true },
	} },
}
lspconfig.ltex.setup {
	settings = { ltex = {
		additionalRules = {
			enablePickyRules = true,
			motherTongue = "pt-BR",
		},
	} },
}

require("nvim-treesitter.configs").setup {
	ensure_installed = { "rust", "c", "latex" },
	parser_install_dir = vim.fn.stdpath "data" .. "/site",
	highlight = { enable = true },
	indent = { enable = true },
}

-- * overrides a default keymap
-- ** overrides a default keymap with similar functionality
