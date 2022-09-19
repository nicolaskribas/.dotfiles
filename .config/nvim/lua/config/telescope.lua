local telescope = require "telescope"

telescope.setup {
	defaults = {
		sorting_strategy = "ascending",
		layout_config = { prompt_position = "top" },
		borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
	},
	pickers = {
		git_files = { show_untracked = true },
	},
}

telescope.load_extension "fzf"

local builtin = require "telescope.builtin"
local map = vim.keymap.set
map("n", "<leader>ff", builtin.find_files)
map("n", "<leader>fg", builtin.git_files)
map("n", "<leader>fw", builtin.live_grep)
map("n", "<leader>fb", builtin.buffers)
map("n", "<leader>fh", builtin.help_tags)
map("n", "<leader>/", builtin.current_buffer_fuzzy_find)
