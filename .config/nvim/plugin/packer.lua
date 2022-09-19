-- install packer (plugin manager)
local bootstrap = function()
	local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
	if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
		vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
		vim.cmd [[packadd packer.nvim]]
		return true
	end
	return false
end
local just_installed = bootstrap()

-- install plugins
require("packer").startup {
	function(use)
		use { "wbthomason/packer.nvim" } -- packer manages itself
		use {
			"numToStr/Comment.nvim", -- comment out the visual selection/entire line
			config = [[require "config.comment"]],
		}
		use {
			"windwp/nvim-autopairs", -- automatically close pairs of characters
			config = [[require("nvim-autopairs").setup()]],
		}
		use {
			"nvim-telescope/telescope.nvim", -- search and find a lot of things
			requires = {
				"nvim-lua/plenary.nvim",
				"kyazdani42/nvim-web-devicons",
				{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
			},
			config = [[require "config.telescope"]],
		}
		use {
			"rose-pine/neovim", -- color scheme
			config = [[require "config.colorscheme"]],
		}
		use {
			"lewis6991/gitsigns.nvim", -- git related info in the signs columns
			config = [[require "config.gitsigns"]],
		}
		use {
			"nvim-treesitter/nvim-treesitter", -- language parsing for better highlight and indentation
			requires = "nvim-treesitter/nvim-treesitter-textobjects",
			run = ":TSUpdate",
			config = [[require "config.treesitter"]],
		}
		use {
			"neovim/nvim-lspconfig", -- lsp client configurations for multiple language servers
			requires = "hrsh7th/cmp-nvim-lsp",
			config = [[require "config.lsp"]],
		}
		use {
			"jose-elias-alvarez/null-ls.nvim", -- inject lsp features provided by sources other than language servers
			require = "nvim-lua/plenary.nvim",
			config = [[require "config.null_ls"]],
		}
		use {
			"hrsh7th/nvim-cmp", -- autocompletion
			requires = {
				"L3MON4D3/LuaSnip", -- snippet engine, required by nvim-cmp
				"hrsh7th/cmp-nvim-lsp", -- autocompletion source for lsp client
				"hrsh7th/cmp-buffer",
			},
			config = [[require "config.cmp"]],
		}

		if just_installed then
			require("packer").sync()
		end
	end,
}
