local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.cmd [[
	augroup Packer
		autocmd!
		autocmd BufWritePost init.lua PackerCompile
	augroup end
]]

local use = require('packer').use
require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use 'tpope/vim-commentary'
	use {
		'nvim-telescope/telescope.nvim',
		requires = { 'nvim-lua/plenary.nvim' },
		config = [[require('config.telescope')]], 
	}
	use 'arcticicestudio/nord-vim'
	use {
		'nvim-lualine/lualine.nvim', -- fancier statusline
		requires = { 'kyazdani42/nvim-web-devicons' },
		config = [[require('config.lualine')]],
	}
	use {
		'lewis6991/gitsigns.nvim',
		requires = { 'nvim-lua/plenary.nvim' },
		config = [[require('config.gitsigns')]],
	}
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		config = [[require('config.treesitter')]],
	}
	use {
		'neovim/nvim-lspconfig',
		config = [[require('config.lsp')]],
	}
	use {
		'hrsh7th/nvim-cmp',
		requires = {
			'hrsh7th/cmp-nvim-lsp',
			'saadparwaiz1/cmp_luasnip',
			'L3MON4D3/LuaSnip',
		},
		config = [[require('config.cmp')]],
	}
end)
