local gitsigns = require "gitsigns"
gitsigns.setup {
	preview_config = { border = "none" },
	on_attach = function(buf)
		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = buf
			vim.keymap.set(mode, l, r, opts)
		end

		-- navigation
		map("n", "]c", function()
			if vim.wo.diff then
				return "]c"
			end
			vim.schedule(function()
				gitsigns.next_hunk()
			end)
			return "<Ignore>"
		end, { expr = true })

		map("n", "[c", function()
			if vim.wo.diff then
				return "[c"
			end
			vim.schedule(function()
				gitsigns.prev_hunk()
			end)
			return "<Ignore>"
		end, { expr = true })

		-- actions
		map({ "n", "v" }, "<leader>gs", ":Gitsigns stage_hunk<CR>")
		map({ "n", "v" }, "<leader>gr", ":Gitsigns reset_hunk<CR>")
		map("n", "<leader>gS", gitsigns.stage_buffer)
		map("n", "<leader>gR", gitsigns.reset_buffer)
		map("n", "<leader>gu", gitsigns.undo_stage_hunk)
		map("n", "<leader>gp", gitsigns.preview_hunk)
		map("n", "<leader>gb", gitsigns.blame_line)
		map("n", "<leader>gd", gitsigns.diffthis)
		map("n", "<leader>gD", function()
			gitsigns.diffthis "~"
		end)

		-- text object
		map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
	end,
}
