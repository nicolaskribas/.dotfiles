require("lualine").setup {
	options = {
		component_separators = "",
		section_separators = "",
		globalstatus = true,
		theme = "rose-pine-alt",
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = {},
		lualine_c = {
			"filetype",
			"filename",
			{ "diagnostics", symbols = { error = " ", warn = " ", hint = " ", info = " " } },
		},
		lualine_x = { "diff" },
		lualine_y = {},
		lualine_z = { { "branch", icon = "" } },
	},
}
