require('nvim-treesitter.configs').setup {
	ensure_installed = 'all', -- install all parsers
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
}
