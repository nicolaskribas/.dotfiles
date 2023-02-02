return {
	"nvim-telescope/telescope.nvim", -- search and find a lot of things
	version = "0.*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"kyazdani42/nvim-web-devicons",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		local telescope = require "telescope"

		telescope.setup {
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
	end,
}
