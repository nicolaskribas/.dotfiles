local lspconfig = require 'lspconfig'
local set_keymaps = function(_, bufnr)
	local function map(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
	local opts = { noremap = true, silent = true }
	map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
	map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
	map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
	map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
	map('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	map('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
	map('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
	map('n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
	map('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
	map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
	map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
	map('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
	map('n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
	map('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts) 
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Enable the following language servers
local servers = { 'rust_analyzer', 'clangd', 'hls' }
for _, server in ipairs(servers) do
	lspconfig[server].setup {
		on_attach = set_keymaps,
		capabilities = capabilities,
	}
end
