-- install packer (plugin manager)
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', { command = 'source <afile> | PackerCompile', group = packer_group, pattern = 'init.lua' })

-- install plugins
require('packer').startup(function(use)
	use 'wbthomason/packer.nvim' -- manage itself
	use {
		'numToStr/Comment.nvim', -- 'gc'/'gcc' to comment visual selection/entire line
		config = [[require('config.comment')]],
	}
	use {
		'windwp/nvim-autopairs', -- automatically close pairs of characters
		config = [[require('config.autopairs')]],
	}
	use {
		'nvim-telescope/telescope.nvim', -- find files and content in files
		requires = {
			'nvim-lua/plenary.nvim',
			'kyazdani42/nvim-web-devicons',
			{ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
		},
		config = [[require('config.telescope')]],
	}
	use {
		'andersevenrud/nordic.nvim', -- color scheme
		config = [[require('config.nordic')]],
	}
	use {
		'nvim-lualine/lualine.nvim', -- fancier statusline
		requires = { 'kyazdani42/nvim-web-devicons' },
		config = [[require('config.lualine')]],
	}
	use {
		'lewis6991/gitsigns.nvim', -- git related info in the signs columns
		requires = { 'nvim-lua/plenary.nvim' },
		config = [[require('config.gitsigns')]],
	}
	use {
		'nvim-treesitter/nvim-treesitter', -- language parsing for better highlight and indentation
		run = ':TSUpdate',
		config = [[require('config.treesitter')]],
	}
	use {
		'neovim/nvim-lspconfig', -- lsp client configurations for multiple language servers
		requires = { 'hrsh7th/cmp-nvim-lsp' },
		config = [[require('config.lsp')]],
	}
	use {
		'hrsh7th/nvim-cmp', -- autocompletion
		requires = {
			'L3MON4D3/LuaSnip', -- snippet engine, required by nvim-cmp
			'saadparwaiz1/cmp_luasnip', -- autocompletion source for luasnip
			'hrsh7th/cmp-nvim-lsp', -- autocompletion source for lsp client
		},
		config = [[require('config.cmp')]],
	}
end)
