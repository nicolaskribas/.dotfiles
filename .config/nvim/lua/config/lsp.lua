-- turn on lsp status information
require("fidget").setup()

local on_attach = function(_, buf)
	local map = vim.keymap.set
	local lsp = vim.lsp.buf
	local opts = { buffer = buf }

	map("n", "K", lsp.hover, opts)
	map("i", "<C-s>", lsp.signature_help, opts)
	map("n", "<leader>li", lsp.implementation, opts)
	map("n", "<leader>lt", lsp.type_definition, opts)
	map("n", "<leader>lr", lsp.references, opts)
	map("n", "<leader>lR", lsp.rename, opts)
	map("n", "<leader>lA", lsp.code_action, opts)
	vim.api.nvim_buf_set_option(buf, "omnifunc", "v:lua.vim.lsp.omnifunc")
	vim.api.nvim_buf_set_option(buf, "tagfunc", "v:lua.vim.lsp.tagfunc")
	vim.api.nvim_buf_set_option(buf, "formatexpr", "v:lua.vim.lsp.formatexpr()")
	-- vim.api.nvim_create_autocmd("CursorHold", { callback = lsp.document_highlight })
	-- vim.api.nvim_create_autocmd("CursorMoved", { callback = lsp.clear_references })
end

-- nvim-cmp supports additional completion capabilities
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local defaults = {
	on_attach = on_attach,
	capabilities = capabilities,
}

local function apply_defaults(config)
	config = config or {}
	return vim.tbl_deep_extend("keep", config, defaults)
end

-- enable the following language servers
local servers = {
	"clangd",
	"gopls",
	"rust_analyzer",
	"hls",
	"jedi_language_server",
	"sumneko_lua",
	"ltex",
	"texlab",
}

local configs = {}
configs.sumneko_lua = {
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			diagnostics = { globals = { "vim" } },
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
		},
	},
}
configs.ltex = {
	settings = {
		ltex = {
			language = "en-US",--[[ "pt-BR" ]]
		},
	},
}

local lspconfig = require "lspconfig"
for _, server in ipairs(servers) do
	local config = apply_defaults(configs[server])
	lspconfig[server].setup(config)
end
