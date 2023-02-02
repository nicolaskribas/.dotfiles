return {
	"hrsh7th/nvim-cmp", -- autocompletion
	dependencies = {
		{ "L3MON4D3/LuaSnip", version = "1.*" }, -- snippet engine, required by nvim-cmp
		"hrsh7th/cmp-nvim-lsp", -- autocompletion source for lsp client
		"hrsh7th/cmp-buffer",
	},
	config = function()
		local cmp = require "cmp"
		local luasnip = require "luasnip"

		cmp.setup {
			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert {
				["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
				["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-d>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<C-y>"] = cmp.mapping.confirm { select = true },
			},
			sources = {
				{ name = "nvim_lsp" },
				{ name = "buffer", keyword_length = 4 },
			},
		}
	end,
}
