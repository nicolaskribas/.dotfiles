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

-- set colorscheme (order is important here)
vim.o.termguicolors = true
vim.g.nord_italic = 1
vim.g.nord_italic_comments = 1
vim.g.nord_underline = 1
vim.cmd [[colorscheme nord]]

-- set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- disable current mode message
vim.o.showmode = false

-- highlight on yank
vim.cmd [[
	augroup YankHighlight
		autocmd!
		autocmd TextYankPost * silent! lua vim.highlight.on_yank()
	augroup end
]]