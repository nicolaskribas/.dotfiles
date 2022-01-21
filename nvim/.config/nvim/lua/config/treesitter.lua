require('nvim-treesitter.configs').setup {
	ensure_installed = 'maintained', -- install all parsers that are stable and maintained
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
}
