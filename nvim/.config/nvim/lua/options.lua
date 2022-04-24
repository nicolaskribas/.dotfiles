-- set indenting
vim.opt.tabstop = 4
vim.opt.shiftwidth = 0

-- disable highlight on search
vim.o.hlsearch = false

-- show line numbers
vim.wo.number = true
vim.wo.relativenumber = true

-- enable mouse mode
vim.o.mouse = 'a'

-- enable break indent
vim.o.breakindent = true

-- save undo history
vim.opt.undofile = true

-- case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- set guide line for text alignment
vim.wo.colorcolumn = '100'

-- disable text wraping
vim.wo.wrap = false

-- enable true color
vim.o.termguicolors = true

-- set colorscheme
vim.cmd [[colorscheme nordic]]

-- set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- disable current mode message
vim.o.showmode = false

-- highlight on yank
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = '*',
})
