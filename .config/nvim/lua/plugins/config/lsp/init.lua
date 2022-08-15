local set_keymaps = function(_, bufnr)
	local function map(mode, l, r, opts)
		opts = opts or {}
		opts.buffer = bufnr
		vim.keymap.set(mode, l, r, opts)
	end
	local lsp = vim.lsp.buf

	map("n", "gD", lsp.declaration)
	map("n", "gd", lsp.definition)
	map("n", "K", lsp.hover)
	map("n", "<C-k>", lsp.signature_help)
	map("n", "gi", lsp.implementation)
	map("n", "gt", lsp.type_definition)
	map("n", "<leader>lr", lsp.rename)
	map("n", "<leader>la", lsp.code_action)
	map("n", "<leader>lf", lsp.formatting)
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local defaults = {
	on_attach = set_keymaps,
	capabilities = capabilities,
}

local function apply_defaults(config)
	config = config or {}
	return vim.tbl_deep_extend("keep", config, defaults)
end

-- fetch server specific configs located at plugins/config/lsp/servers
local function custom_config(server)
	local ok, config = pcall(require, "plugins.config.lsp.servers." .. server)
	if ok then
		return config
	end
end

-- enable the following language servers
local servers = { "clangd", "gopls", "rust_analyzer", "hls", "sumneko_lua", "jedi_language_server" }

local lspconfig = require "lspconfig"
for _, server in ipairs(servers) do
	local config = apply_defaults(custom_config(server))
	lspconfig[server].setup(config)
end
