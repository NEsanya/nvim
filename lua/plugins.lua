return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- LSP
	use 'neovim/nvim-lspconfig'
  
  -- Theem
  use { 
    "catppuccin/nvim", 
    as = "catppuccin",
    config = function()
      require('catppuccin').setup {
        flavour = 'macchiato'
      }
      vim.cmd.colorscheme 'catppuccin'
    end
  }

  -- Status line
	use {
		'nvim-lualine/lualine.nvim',
		requires = { 'kyazdani42/nvim-web-devicons', opt = true },
	}

  -- Autocompetition
  use {
    'hrsh7th/nvim-cmp',
    requires = { 
      'hrsh7th/cmp-nvim-lsp', 
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline'
    }
  }

  -- Snippets
  use {
    'L3MON4D3/LuaSnip',
    requires = { 'saadparwaiz1/cmp_luasnip' }
  }
end)
