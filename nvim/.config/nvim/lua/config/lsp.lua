local lspconfig = require 'lspconfig'
local set_keymaps = function(_, bufnr)
	local opts = { buffer = bufnr }
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
	vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
	vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
	vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
	vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, opts)
	vim.keymap.set('n', '<leader>f', vim.lsp.buf.formatting, opts)
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- add borders to the floating windows
local handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "double" }),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "double" }),
}

-- enable the following language servers
local servers = { 'rust_analyzer', 'clangd', 'hls', 'gopls', 'sumneko_lua', 'jedi_language_server' }
for _, server in ipairs(servers) do
	lspconfig[server].setup {
		on_attach = set_keymaps,
		capabilities = capabilities,
		handlers = handlers,
	}
end
