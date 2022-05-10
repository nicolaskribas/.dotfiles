local cmp = require "cmp"
local luasnip = require "luasnip"
local lspkind = require "lspkind"

cmp.setup {
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert {
		["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Select },
		["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Select },
		["<C-u>"] = cmp.mapping.scroll_docs(-4),
		["<C-d>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<C-y>"] = cmp.mapping.confirm { select = true },
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "buffer", keyword_length = 4 },
	},
	formatting = {
		fields = { "kind", "abbr", "menu" },
		format = lspkind.cmp_format {
			maxwidth = 50,
			mode = "symbol",
			menu = {
				nvim_lsp = "[lsp]",
				buffer = "[buf]",
			},
		},
	},
}
