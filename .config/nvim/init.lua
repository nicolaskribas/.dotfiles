local opt = vim.opt
opt.tabstop = 8
opt.shiftwidth = 0 -- 0 means: same value as 'tabstop'
opt.shiftround = true -- round indent to multiples of 'shifwidth'
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.fillchars = { eob = " " }
opt.guicursor:append "c:ver25" -- vertical bar as cursor when inserting in command-line mode
opt.guicursor:append "a:blinkwait1-blinkon500-blinkoff500" -- make cursor blink
opt.guicursor:append "a:Cursor" -- make cursor follow neovim colorscheme
opt.cursorline = true
opt.colorcolumn = "81"
opt.mouse = "a"
opt.undofile = true -- save undo history between sessions
opt.virtualedit = "block" -- allow placing the cursor where no character exist when in visual block
opt.ignorecase = true
opt.smartcase = true
opt.gdefault = true -- substitute all matches in a line by default
opt.wrap = false
opt.linebreak = true -- use 'breakat' for determine when to wrap
opt.spell = true
opt.spelllang = "en_us"
opt.splitbelow = true
opt.splitright = true
opt.pumheight = 10
opt.completeopt = { "menuone", "noinsert", "noselect" }
opt.shortmess:append "c"
opt.wildmode = { "longest:full:lastused", "full" } -- complete until longest common string, then iterate over other matches, sort buffers by last used
opt.path:append "**" -- recursive :find
opt.grepprg = "rg --hidden --smart-case --vimgrep"
opt.grepformat:prepend "%f:%l:%c:%m"
opt.diffopt:append { "indent-heuristic", "algorithm:histogram" }
vim.diagnostic.config { virtual_text = false, severity_sort = true }
vim.cmd.highlight "Comment gui=italic cterm=italic"

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.netrw_banner = false
vim.g.netrw_winsize = 20 -- 20%

local map = vim.keymap.set
map("", "<Space>", "<NOP>") -- disable space, it is the leader key

-- resizing windows
-- <C-w> is better then :resize/:vertical as it allows being multipied by a 'count'
map("n", "<Left>", "<C-w>>")
map("n", "<Right>", "<C-w><")
map("n", "<Up>", "<C-w>-")
map("n", "<Down>", "<C-w>+")

-- use system clipboard
map({ "n", "x" }, "<Leader>y", '"+y')
map({ "n", "x" }, "<Leader>Y", '"+Y', { remap = true }) -- recursive: Y is mapped to y$ by default
map({ "n", "x" }, "<Leader>p", '"+p')
map({ "n", "x" }, "<Leader>P", '"+P')

-- dealing with word wrap
map({ "n", "x" }, "j", "gj")
map({ "n", "x" }, "k", "gk")
map({ "n", "x" }, "gj", "j")
map({ "n", "x" }, "gk", "k")

map("n", "<Leader>qd", vim.diagnostic.setqflist)
map("n", "<Leader>qe", function() vim.diagnostic.setqflist { severity = vim.diagnostic.severity.ERROR } end)
map("n", "<Leader>qw", function() vim.diagnostic.setqflist { severity = vim.diagnostic.severity.WARN } end)
map("n", "]q", "<Cmd>cnext<CR>")
map("n", "[q", "<Cmd>cprev<CR>")
map("n", "]l", "<Cmd>lnext<CR>")
map("n", "[l", "<Cmd>lprev<CR>")
map("n", "]b", "<Cmd>bnext<CR>")
map("n", "[b", "<Cmd>bprev<CR>")
map("n", "]a", "<Cmd>next<CR>")
map("n", "[a", "<Cmd>prev<CR>")

-- like :grep but silent, opens the quickfix window automatically and invert the bang logic (do not jump to first result by default)
vim.api.nvim_create_user_command("Grep", function(args)
	vim.cmd.grep { args.args, bang = not args.bang, mods = { silent = true } }
	vim.cmd.copen()
end, { bang = true, nargs = "+", complete = "file" })

vim.api.nvim_create_user_command("Lgrep", function(args)
	vim.cmd.lgrep { args.args, bang = not args.bang, mods = { silent = true } }
	vim.cmd.lopen()
end, { bang = true, nargs = "+", complete = "file" })

local init = vim.api.nvim_create_augroup("Init", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = init,
	pattern = { "tex", "plaintex", "markdown" },
	command = "setlocal wrap breakindent colorcolumn=",
})
vim.api.nvim_create_autocmd("TextYankPost", {
	group = init,
	callback = function() vim.highlight.on_yank { on_visual = false } end,
})

for _, v in ipairs { "textDocument/implementation", "textDocument/references", "textDocument/documentSymbol" } do
	vim.lsp.handlers[v] = vim.lsp.with(vim.lsp.handlers[v], { loclist = true })
end

vim.api.nvim_create_autocmd("LspAttach", {
	group = init,
	callback = function(args)
		vim.bo[args.buf].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"

		local lsp = vim.lsp.buf
		local opts = { buffer = args.buf }
		map("n", "gd", lsp.declaration, opts) -- ** for definition use Ctrl-]
		map("n", "gD", lsp.type_definition, opts) -- **
		map({ "n", "i" }, "<C-s>", lsp.signature_help, opts)
		map({ "n", "x" }, "<Leader>ca", lsp.code_action, opts)
		map({ "n", "x" }, "<Leader>cf", lsp.format, opts)
		map("n", "<Leader>cw", lsp.rename, opts)
		map("n", "<Leader>ls", lsp.document_symbol, opts)
		map("n", "<Leader>li", lsp.implementation, opts)
		map("n", "<Leader>lr", lsp.references, opts)
		map("n", "<Leader>wa", lsp.add_workspace_folder, opts)
		map("n", "<Leader>wr", lsp.remove_workspace_folder, opts)
		map("n", "<Leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
	end,
})

require("mini.deps").setup()
MiniDeps.add {
	source = "nvim-treesitter/nvim-treesitter",
	hooks = { post_checkout = function() vim.cmd "TSUpdate" end },
}
MiniDeps.add {
	source = "neovim/nvim-lspconfig",
	checkout = "v1.0.0",
}

local words = {}
for word in io.open(vim.fn.stdpath "config" .. "/spell/en.utf-8.add", "r"):lines() do
	table.insert(words, word)
end

local lspconfig = require "lspconfig"
lspconfig.rust_analyzer.setup {}
lspconfig.clangd.setup {}
lspconfig.ruff.setup {}
lspconfig.pyright.setup {
	settings = { python = { pythonPath = ".venv/bin/python" } },
}
lspconfig.texlab.setup {
	settings = { texlab = {
		build = { onSave = true },
		chktex = { onOpenAndSave = true, onEdit = true },
	} },
}
lspconfig.ltex.setup {
	settings = {
		ltex = {
			additionalRules = { enablePickyRules = true },
			languageToolHttpServerUri = "http://localhost:8081",
			dictionary = { ["en-US"] = words },
		},
	},
}

require("nvim-treesitter.configs").setup {
	ensure_installed = "all",
	parser_install_dir = vim.fn.stdpath "data" .. "/site",
	highlight = { enable = true },
	indent = { enable = true },
}

require("mini.trailspace").setup {}

require("mini.completion").setup {
	lsp_completion = { source_func = "omnifunc", auto_setup = false },
	set_vim_settings = false,
}

require("mini.bufremove").setup {
	set_vim_settings = false,
}

-- TODO: make it work more like :bdelete (e.g. accepting the file name)
vim.api.nvim_create_user_command("Bdelete", function(args)
	local buf_id
	if args.args ~= "" then
		buf_id = tonumber(args.args)
	else
		buf_id = 0
	end
	if buf_id ~= nil then MiniBufremove.delete(buf_id, args.bang) end
end, { bang = true, nargs = "?" })

require("mini.pick").setup { window = { config = { border = "none" } } }
map("n", "<Leader>ff", MiniPick.builtin.files)
map("n", "<Leader>fg", MiniPick.builtin.grep)
map("n", "<Leader>fl", MiniPick.builtin.grep_live)
map("n", "<Leader>fb", MiniPick.builtin.buffers)
map("n", "<Leader>fr", MiniPick.builtin.resume)

-- * overrides a default keymap
-- ** overrides a default keymap with similar functionality
