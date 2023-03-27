vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use 'folke/tokyonight.nvim' -- Colorscheme
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
  use 'airblade/vim-gitgutter' -- Git symbols in the gutter
  -- Utilities
  use 'machakann/vim-highlightedyank' -- Highlight yanked text
  use {
      'nvim-telescope/telescope.nvim', tag = '0.1.1',
      requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
  }
  use 'preservim/nerdcommenter' -- Commenting boost, use <leader>cc to to toggle comments
  use 'mbbill/undotree' -- Undo tree
  use 'scrooloose/nerdtree' -- Nerdtree
  use 'tpope/vim-repeat' -- Smarter . (dot) functionality
  use 'tpope/vim-surround' -- Management of open-close pairs of ([{< etc.
  use 'tpope/vim-unimpaired' -- ]p ]<Space> and ]b useful commands
  use 'github/copilot.vim'
  use 'numToStr/FTerm.nvim' -- Floating terminal
  use 'lervag/vimtex' -- Latex support
  -- LSP 
  use {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v1.x',
      requires = {
          -- LSP Support
          {'neovim/nvim-lspconfig'},             
          {'williamboman/mason.nvim'}, -- Marketplace like
          {'williamboman/mason-lspconfig.nvim'},
          -- Autocompletion
          {'hrsh7th/nvim-cmp'},         
          {'hrsh7th/cmp-nvim-lsp'},    
          {'hrsh7th/cmp-buffer'},     
          {'hrsh7th/cmp-path'},       
          {'saadparwaiz1/cmp_luasnip'},
          {'hrsh7th/cmp-nvim-lua'},   
          -- Snippets
          {'L3MON4D3/LuaSnip'},       
          {'rafamadriz/friendly-snippets'},
      }
  }
end)
