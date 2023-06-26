local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- LSP
  use 'neovim/nvim-lspconfig'

  -- Theme
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

  if packer_bootstrap then
    require('packer').sync()
  end

  use {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  }

  -- Tree sitter
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end
  }

  -- Auto close brakets
  use {
    'm4xshen/autoclose.nvim',
    config = function()
      require('autoclose').setup()
    end
  }

  -- Colorized brakets and lines
  use {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      require('indent_blankline').setup {
        space_char_blankline = ' ',
        show_current_context = true,
        show_current_context_start = true,
      }
    end
  }
end)
