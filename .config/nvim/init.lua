local opt = vim.opt
opt.tabstop = 8
opt.shiftwidth = 0 -- 0 means: same value as 'tabstop'
opt.shiftround = true -- round indent to multiples of 'shifwidth'
opt.number = true
opt.relativenumber = true
opt.ruler = false
opt.signcolumn = "yes"
opt.guicursor:append { "c:ver25", "t:ver25" } -- vertical bar as cursor when inserting in command-line mode, and when in terminal mode
opt.guicursor:append "a:blinkwait1-blinkon500-blinkoff500" -- make cursor blink
opt.guicursor:append "a:Cursor" -- make cursor follow neovim colorscheme
opt.title = true
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
-- opt.spell = true
-- opt.spelllang = { "en_us", "pt_br" }
opt.splitbelow = true
opt.splitright = true
opt.pumheight = 10
opt.completeopt = { "fuzzy", "menuone", "noselect", "popup" }
-- opt.shortmess:append "c"
opt.wildmode = { "longest:full:lastused", "full" } -- complete until longest common string, then iterate over other matches, sort buffers by last used
opt.path:append "**" -- recursive :find
opt.grepprg = "rg --hidden --smart-case --vimgrep"
opt.grepformat:prepend "%f:%l:%c:%m"
opt.diffopt:append { "algorithm:histogram" }
vim.diagnostic.config {
	underline = false,
	severity_sort = true,
	jump = { on_jump = vim.diagnostic.open_float },
	float = { source = "if_many" },
}
vim.cmd.colorscheme "default"
vim.cmd.highlight "Comment gui=italic cterm=italic"

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
map("n", "<Leader>qw", function() vim.diagnostic.setqflist { severity = { min = vim.diagnostic.severity.WARN } } end)

map({ "n", "v" }, "<Leader>", [["+]])

-- taken from https://github.com/MariaSolOs/dotfiles/blob/main/.config/nvim/filetype.lua
vim.filetype.add {
	pattern = {
		[".*"] = function(path, bufnr)
			return vim.bo[bufnr].filetype ~= "bigfile"
					and vim.fn.getfsize(path) > (1024 * 256) -- 256 KiB
					and "bigfile"
				or nil
		end,
	},
}

local init = vim.api.nvim_create_augroup("Init", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = init,
	pattern = { "markdown", "tex" },
	command = "setlocal textwidth=80",
})
vim.api.nvim_create_autocmd("TextYankPost", {
	group = init,
	callback = function() vim.hl.on_yank { on_visual = false } end,
})
vim.api.nvim_create_autocmd("LspAttach", {
	group = init,
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client:supports_method "textDocument/completion" then
			-- local var_name_chars = vim.split("_abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789", "")
			-- vim.list_extend(client.server_capabilities.completionProvider.triggerCharacters or {}, var_name_chars)
			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
		end

		local lsp = vim.lsp.buf
		local opts = { buf = args.buf }
		map({ "n", "x" }, "grf", lsp.format, opts)
		map("n", "<Leader>wa", lsp.add_workspace_folder, opts)
		map("n", "<Leader>wr", lsp.remove_workspace_folder, opts)
		map("n", "<Leader>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
	end,
})
vim.api.nvim_create_autocmd("LspProgress", {
	group = init,
	buffer = buf,
	callback = function(ev)
		local value = ev.data.params.value
		vim.api.nvim_echo({ { value.message or "done" } }, false, {
			id = "lsp." .. ev.data.params.token,
			kind = "progress",
			percent = value.percentage,
			source = "vim.lsp",
			status = value.kind ~= "end" and "running" or "success",
			title = value.title,
		})
	end,
})
vim.api.nvim_create_autocmd("FileType", {
	group = init,
	pattern = "bigfile",
	callback = function(args)
		vim.schedule(function() vim.bo[args.buf].syntax = vim.filetype.match { buf = args.buf } or "" end)
	end,
})

vim.pack.add { {
	src = "https://github.com/neovim/nvim-lspconfig",
	version = vim.version.range "^v2.7.0",
} }
vim.lsp.enable {
	"rust_analyzer",
	"clangd",
	"bashls",
	"marksman",
	"ruff",
	"ty",
	"pyright",
	"texlab",
	"ltex_plus",
	-- "vale_ls",
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
			languageToolHttpServerUri = "https://languagetool.asymptote-shark.ts.net",
			additionalRules = { enablePickyRules = true },
			dictionary = {
				["en-US"] = get_dict "en",
				["pt-BR"] = get_dict "pt",
			},
			disabledRules = {}, -- see: https://community.languagetool.org/rule/list
		},
	},
})

vim.schedule(function()
	vim.pack.add { "https://github.com/ibhagwan/fzf-lua" }
	require("fzf-lua").setup {
		winopts = { border = "none", preview = { border = "none" } },
		files = { raw_cmd = "fd --follow --type=file" },
		grep = { follow = true },
		keymap = { builtin = {
			["<C-d>"] = "preview-half-page-down",
			["<C-u>"] = "preview-half-page-up",
		} },
	}
	map("n", "<Leader>ff", FzfLua.files)
	map("n", "<Leader>fg", FzfLua.live_grep)
	map("n", "<Leader>fa", FzfLua.args)
	map("n", "<Leader>fb", FzfLua.buffers)
	map("n", "<Leader>fd", FzfLua.diagnostics_document)
	map("n", "<Leader>fq", FzfLua.quickfix)
	map("n", "<Leader>fl", FzfLua.loclist)
	map("n", "<Leader>f*", FzfLua.grep_cword)
	map("v", "<Leader>f*", FzfLua.grep_visual)
	map("n", "<Leader>f/", FzfLua.lines)
	map("n", "<Leader>fr", FzfLua.resume)
end)
