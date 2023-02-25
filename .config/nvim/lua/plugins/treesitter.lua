return {
	"nvim-treesitter/nvim-treesitter", -- language parsing for better highlight and indentation
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup {
			ensure_installed = "all",
			highlight = { enable = true },
			indent = { enable = true },
		}
	end,
}
