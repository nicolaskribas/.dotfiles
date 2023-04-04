return {
	"rose-pine/neovim", -- color scheme
	config = function()
		require("rose-pine").setup {
			disable_italics = true,
			highlight_groups = {
				TelescopeTitle = { fg = "surface", bg = "foam" },
				TelescopeResultsTitle = { fg = "surface", bg = "surface" },
				TelescopeBorder = { fg = "surface", bg = "surface" },
				TelescopePromptBorder = { fg = "overlay", bg = "overlay" },
				TelescopePromptNormal = { fg = "text", bg = "overlay" },
			},
		}

		vim.cmd "colorscheme rose-pine"
	end,
}
