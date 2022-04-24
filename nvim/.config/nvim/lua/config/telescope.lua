require('telescope').setup {
	defaults = {
		mappings = {
			i = {
				['<C-u>'] = false,
				['<C-d>'] = false,
			},
		},
	},
}

require('telescope').load_extension('fzf')

vim.keymap.set('n', '<leader>sf', require('config.telescope-func').files)
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep)
vim.keymap.set('n', '<leader>sc', require('telescope.builtin').current_buffer_fuzzy_find)
vim.keymap.set('n', '<leader>sb', require('telescope.builtin').buffers)
vim.keymap.set('n', '<leader>so', require('telescope.builtin').oldfiles)
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags)
