local opt = vim.opt
opt.tabstop = 8
opt.shiftwidth = 0 -- 0 means: same value as 'tabstop'
opt.shiftround = true -- round indent to multiples of 'shifwidth'
opt.number = true
opt.relativenumber = true
opt.ruler = false
opt.signcolumn = "yes"
opt.guicursor:append "c:ver25" -- vertical bar as cursor when inserting in command-line mode
opt.guicursor:append "a:blinkwait1-blinkon500-blinkoff500" -- make cursor blink
opt.guicursor:append "a:Cursor" -- make cursor follow neovim colorscheme
opt.cursorline = true
opt.colorcolumn = "+1"
opt.mouse = "a"
opt.undofile = true -- save undo history between sessions
opt.virtualedit = "block" -- allow placing the cursor where no character exist when in visual block
opt.ignorecase = true
opt.smartcase = true
opt.gdefault = true -- substitute all matches in a line by default
opt.wrap = false
opt.linebreak = true -- use 'breakat' for determine when to wrap
opt.breakindent = true
opt.spell = true
opt.spelllang = { "en_us", "pt_br" }
opt.splitbelow = true
opt.splitright = true
opt.pumheight = 10
opt.completeopt = { "fuzzy", "menuone", "noinsert", "noselect" }
opt.shortmess:append "c"
opt.wildmode = { "longest:full:lastused", "full" } -- complete until longest common string, then iterate over other matches, sort buffers by last used
opt.path:append "**" -- recursive :find
opt.grepprg = "rg --hidden --smart-case --vimgrep"
opt.grepformat:prepend "%f:%l:%c:%m"
opt.diffopt:append { "indent-heuristic", "algorithm:histogram" }
vim.diagnostic.config { underline = false, severity_sort = true }
vim.cmd.highlight "Comment gui=italic cterm=italic"
vim.cmd.highlight "StatusLine guifg=fg guibg=bg gui=bold cterm=bold"
vim.cmd.highlight "StatusLineNC guifg=fg guibg=bg"

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.netrw_banner = false
vim.g.netrw_winsize = 20 -- 20%
vim.g.tex_flavor = "latex" -- |ft-tex-plugin|

local map = vim.keymap.set
map("", "<Space>", "<NOP>") -- disable space, it is the leader key

-- dealing with word wrap
map({ "n", "x" }, "j", function() return vim.v.count == 0 and "gj" or "j" end, { expr = true })
map({ "n", "x" }, "k", function() return vim.v.count == 0 and "gk" or "k" end, { expr = true })
map({ "n", "x" }, "gj", "j")
map({ "n", "x" }, "gk", "k")

map("n", "<Leader>qd", vim.diagnostic.setqflist)
map("n", "<Leader>qe", function() vim.diagnostic.setqflist { severity = vim.diagnostic.severity.ERROR } end)
map("n", "<Leader>qw", function() vim.diagnostic.setqflist { severity = vim.diagnostic.severity.WARN } end)

local init = vim.api.nvim_create_augroup("Init", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = init,
	pattern = { "markdown", "tex" },
	command = "setlocal textwidth=80",
})
vim.api.nvim_create_autocmd("FileType", {
	group = init,
	callback = function(args)
		if vim.treesitter.language.add(vim.treesitter.language.get_lang(args.match)) then vim.treesitter.start() end
	end,
})
vim.api.nvim_create_autocmd("TextYankPost", {
	group = init,
	callback = function() vim.highlight.on_yank { on_visual = false } end,
})
vim.api.nvim_create_autocmd("LspAttach", {
	group = init,
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client:supports_method "textDocument/completion" then
			local var_name_chars = vim.split("_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789", "")
			vim.list_extend(client.server_capabilities.completionProvider.triggerCharacters or {}, var_name_chars)
			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
		end

		local lsp = vim.lsp.buf
		local opts = { buffer = args.buf }
		map("n", "gd", lsp.declaration, opts) -- ** for definition use Ctrl-]
		map("n", "gD", lsp.type_definition, opts) -- **
		map({ "n", "x" }, "grf", lsp.format, opts)
		map("n", "<Leader>wa", lsp.add_workspace_folder, opts)
		map("n", "<Leader>wr", lsp.remove_workspace_folder, opts)
		map("n", "<Leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
	end,
})

require("mini.deps").setup()
local add, now, later = MiniDeps.add, MiniDeps.now, MiniDeps.later

add {
	source = "nvim-treesitter/nvim-treesitter",
	checkout = "main",
	hooks = {
		post_install = function(args)
			vim.cmd.packadd(args.name)
			require("nvim-treesitter").install({ "stable", "unstable" }):wait()
		end,
		post_checkout = function()
			require("nvim-treesitter").install({ "stable", "unstable" }):wait()
			require("nvim-treesitter").update():wait()
		end,
	},
}

add {
	source = "neovim/nvim-lspconfig",
	checkout = "v2.3.0",
}
vim.lsp.enable {
	"rust_analyzer",
	"clangd",
	"bashls",
	"marksman",
	"ruff",
	"pyright",
	"texlab",
	"harper_ls",
	"ltex_plus",
}
vim.lsp.config("pyright", {
	settings = { python = { pythonPath = ".venv/bin/python" } },
})
vim.lsp.config("texlab", {
	settings = {
		texlab = {
			build = { onSave = true },
			chktex = { onOpenAndSave = true, onEdit = true },
			latexindent = {
				modifyLineBreaks = true,
				["local"] = (vim.env.XDG_CONFIG_HOME or (vim.env.HOME .. "/.config")) .. "/latexindent.yaml",
			},
		},
	},
})
vim.lsp.config("harper_ls", {
	settings = {
		["harper-ls"] = {
			userDictPath = vim.fn.stdpath "config" .. "/spell/en.utf-8.add",
		},
	},
})
local get_dict = function(lang)
	local file = io.open(vim.fn.stdpath "config" .. "/spell/" .. lang .. ".utf-8.add", "r")
	if not file then return {} end
	local words = {}
	for word in file:lines() do
		table.insert(words, word)
	end
	return words
end
vim.lsp.config("ltex_plus", {
	settings = {
		ltex = {
			languageToolHttpServerUri = "http://localhost:8081",
			additionalRules = { enablePickyRules = true },
			dictionary = {
				["en-US"] = get_dict "en",
				["pt-BR"] = get_dict "pt",
			},
			disabledRules = {}, -- see: https://community.languagetool.org/rule/list
		},
	},
})

later(function()
	add {
		source = "nvimtools/none-ls.nvim",
		depends = { "nvim-lua/plenary.nvim" },
	}

	local null_ls = require "null-ls"
	null_ls.setup {
		sources = {
			null_ls.builtins.formatting.stylua,
			null_ls.builtins.formatting.mdformat,
			null_ls.builtins.diagnostics.vale,
			null_ls.builtins.diagnostics.markdownlint_cli2.with { args = { "$FILENAME" } },
		},
	}
end)

later(function() require("mini.trailspace").setup() end)

later(function()
	require("mini.pick").setup { window = { config = { border = "none" } } }
	map("n", "<Leader>ff", function() MiniPick.builtin.files { tool = "fd" } end)
	map("n", "<Leader>fg", MiniPick.builtin.grep)
	map("n", "<Leader>fl", MiniPick.builtin.grep_live)
	map("n", "<Leader>fb", MiniPick.builtin.buffers)
	map("n", "<Leader>fr", MiniPick.builtin.resume)
end)

later(function()
	add "stevearc/oil.nvim"

	require("oil").setup {
		default_file_explorer = false, -- keep using netrw because it is needed for downloading spelling files: https://github.com/neovim/neovim/issues/7189
	}
end)

-- * overrides a default keymap
-- ** overrides a default keymap with similar functionality
