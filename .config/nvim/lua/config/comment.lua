require("Comment").setup {
	ignore = "^$", -- ignore empty lines
	toggler = {
		line = "<leader>cc",
	},
	opleader = {
		line = "<leader>c",
	},
	extra = {
		above = "<leader>cO",
		below = "<leader>co",
		eol = "<leader>cA",
	},
}
