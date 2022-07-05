local telescope = require "telescope"

telescope.setup {
	defaults = {
		sorting_strategy = "ascending",
		layout_config = {
			prompt_position = "top",
		},
	},
}

telescope.load_extension "fzf"

local builtin = require "telescope.builtin"

local function project_files()
	local opts = {}
	local ok = pcall(builtin.git_files, opts)
	if not ok then
		builtin.find_files(opts)
	end
end

local map = vim.keymap.set
map("n", "<leader>ff", project_files)
map("n", "<leader>fw", builtin.live_grep)
map("n", "<leader>fb", builtin.buffers)
map("n", "<leader>fh", builtin.help_tags)
map("n", "<leader>/", builtin.current_buffer_fuzzy_find)

map("n", "gr", builtin.lsp_references)
