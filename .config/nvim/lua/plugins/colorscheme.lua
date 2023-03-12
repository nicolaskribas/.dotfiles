return {
	"rose-pine/neovim", -- color scheme
	config = function()
		require("rose-pine").setup {
			disable_italics = true,
		}

		vim.cmd "colorscheme rose-pine"
	end,
}
