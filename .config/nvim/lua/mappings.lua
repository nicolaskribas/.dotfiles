local map = vim.keymap.set

-- disable space, it is the leader key
map("", "<Space>", "<Nop>")

-- standard operations
map("n", "<leader>w", "<cmd>w<cr>")
map("n", "<leader>q", "<cmd>q<cr>")
map("n", "<leader>h", "<cmd>nohlsearch<cr>")

-- clipboard use
map("", "<leader>y", '"+y')
map("", "<leader>p", '"+p')

-- dealing with word wrap
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- diagnostics
map("n", "<leader>d", vim.diagnostic.open_float)
map("n", "[d", vim.diagnostic.goto_prev)
map("n", "]d", vim.diagnostic.goto_next)
