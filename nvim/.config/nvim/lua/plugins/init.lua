-- install packer (plugin manager)
local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
end

local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd(
	"BufWritePost",
	{ command = "source <afile> | PackerCompile", group = packer_group, pattern = "init.lua" }
)

-- install plugins
require("packer").startup(function(use)
	use "wbthomason/packer.nvim" -- packer manages itself
	use {
		"numToStr/Comment.nvim", -- comment out the visual selection/entire line
		config = [[require('plugins.config.comment')]],
	}
	use {
		"windwp/nvim-autopairs", -- automatically close pairs of characters
		config = [[require('plugins.config.autopairs')]],
	}
	use {
		"nvim-telescope/telescope.nvim", -- search and find a lot of things
		requires = {
			"nvim-lua/plenary.nvim",
			"kyazdani42/nvim-web-devicons",
			{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
		},
		config = [[require('plugins.config.telescope')]],
	}
	use {
		"rose-pine/neovim", -- color scheme
		config = [[require('plugins.config.colorscheme')]],
	}
	use {
		"nvim-lualine/lualine.nvim", -- fancier statusline
		requires = "kyazdani42/nvim-web-devicons",
		config = [[require('plugins.config.lualine')]],
	}
	use {
		"lewis6991/gitsigns.nvim", -- git related info in the signs columns
		config = [[require('plugins.config.gitsigns')]],
	}
	use {
		"rcarriga/nvim-notify", -- floating notifications
		config = [[require('plugins.config.notify')]],
	}
	use {
		"nvim-treesitter/nvim-treesitter", -- language parsing for better highlight and indentation
		requires = "nvim-treesitter/nvim-treesitter-textobjects",
		run = ":TSUpdate",
		config = [[require('plugins.config.treesitter')]],
	}
	use {
		"neovim/nvim-lspconfig", -- lsp client configurations for multiple language servers
		requires = "hrsh7th/cmp-nvim-lsp",
		config = [[require('plugins.config.lsp')]],
	}
	use {
		"jose-elias-alvarez/null-ls.nvim", -- inject lsp features provided by sources other than language servers
		require = "nvim-lua/plenary.nvim",
		config = [[require('plugins.config.null_ls')]],
	}
	use {
		"hrsh7th/nvim-cmp", -- autocompletion
		requires = {
			"L3MON4D3/LuaSnip", -- snippet engine, required by nvim-cmp
			"hrsh7th/cmp-nvim-lsp", -- autocompletion source for lsp client
			"onsails/lspkind.nvim", -- icons for completion items
			"hrsh7th/cmp-buffer",
		},
		config = [[require('plugins.config.cmp')]],
	}
end)
