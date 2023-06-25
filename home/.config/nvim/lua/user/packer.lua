local packer = require 'packer'
packer.startup(function(use)
  use { 'wbthomason/packer.nvim' }

  use { 'lewis6991/impatient.nvim', config = function() require 'impatient'.enable_profile() end }
  use { 'kyazdani42/nvim-web-devicons' }
  use { 'nvim-lua/plenary.nvim' }
  use { 'nvim-lua/popup.nvim' }
  use { 'Joakker/lua-json5', run = 'OSTYPE="linux-gnu" ./install.sh' }

  use { 'rcarriga/nvim-notify', config = function() require 'user.notify' end }
  use { 'gutyina70/darkplus.nvim', config = function() require 'user.colorscheme' end }
  use { 'nvim-lualine/lualine.nvim', config = function() require 'user.lualine' end }
  use { 'akinsho/bufferline.nvim', config = function() require 'user.bufferline' end }
  use { 'kyazdani42/nvim-tree.lua', config = function() require 'user.tree' end }
  use { 'akinsho/toggleterm.nvim', config = function() require 'user.toggleterm' end }
  use { 'kevinhwang91/nvim-bqf', config = function() require 'user.bqf' end }

  use { 'tpope/vim-repeat' }
  use { 'machakann/vim-sandwich', config = function() require 'user.sandwich' end }
  use { 'phaazon/hop.nvim', config = function() require 'user.hop' end }
  use { 'numToStr/Comment.nvim', config = function() require 'user.comment' end }
  use { 'windwp/nvim-autopairs', config = function() require 'user.autopairs' end }
  use { 'ethanholz/nvim-lastplace', config = function() require 'user.lastplace' end }

  use { 'nvim-treesitter/nvim-treesitter', config = function() require 'user.treesitter' end,
    run = function() require 'nvim-treesitter.install'.update { with_sync = true } end, }
  use { 'p00f/nvim-ts-rainbow' }
  use { 'nvim-treesitter/nvim-treesitter-textobjects' }
  use { 'nvim-treesitter/playground' }

  use { 'nvim-telescope/telescope.nvim', config = function() require 'user.telescope' end }
  use { 'nvim-telescope/telescope-file-browser.nvim' }
  use { 'nvim-telescope/telescope-media-files.nvim' }
  use { 'nvim-telescope/telescope-ui-select.nvim' }

  use { 'tpope/vim-fugitive', config = function() require 'user.fugitive' end }
  use { 'tpope/vim-rhubarb' }
  use { 'lewis6991/gitsigns.nvim', config = function() require 'user.gitsigns' end }

  use { 'hrsh7th/nvim-cmp', config = function() require 'user.cmp' end }
  use { 'hrsh7th/cmp-nvim-lsp' }
  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-path' }
  use { 'hrsh7th/cmp-cmdline' }
  use { 'hrsh7th/cmp-nvim-lua' }
  use { 'saadparwaiz1/cmp_luasnip' }
  use { 'L3MON4D3/LuaSnip', config = function() require 'user.snippets' end }
  use { 'rafamadriz/friendly-snippets' }

  use { 'williamboman/mason.nvim', config = function() require 'user.mason' end }
  use { 'WhoIsSethDaniel/mason-tool-installer.nvim' }
  use { 'williamboman/mason-lspconfig.nvim' }
  use { 'neovim/nvim-lspconfig' }
  use { 'jose-elias-alvarez/null-ls.nvim', config = function() require 'user.lsp.null-ls' end }
  use { 'glepnir/lspsaga.nvim', config = function() require 'user.lsp.lspsaga' end }
  use { 'folke/trouble.nvim', config = function() require 'user.lsp.trouble' end }
  use { 'j-hui/fidget.nvim', tag = 'legacy', config = function() require 'user.lsp.fidget' end }

  use { 'mfussenegger/nvim-dap', config = function() require 'user.dap' end }
  use { 'rcarriga/nvim-dap-ui' }
  use { 'theHamsta/nvim-dap-virtual-text' }
  use { 'nvim-telescope/telescope-dap.nvim' }

  use { 'simrat39/rust-tools.nvim', config = function() require 'user.rusttools' end }
  use { 'akinsho/flutter-tools.nvim', config = function() require 'user.fluttertools' end }
  use { 'mfussenegger/nvim-jdtls' }
  use { 'iamcco/markdown-preview.nvim', run = 'cd app && npm install',
    setup = function() vim.g.mkdp_filetypes = { 'markdown' } end, ft = { 'markdown' }, }
  use { 'Hoffs/omnisharp-extended-lsp.nvim' }
  use { 'jbyuki/one-small-step-for-vimkind' }

  use { 'ThePrimeagen/vim-be-good' }
  use { 'moll/vim-bbye' }
  use { 'github/copilot.vim', config = function() require 'user.copilot' end }
end)

require 'user.utils'.register_maps {
  { 'n', '<space>pi', function()
    packer.sync()
    local ok, treesitter_install = pcall(require, 'nvim-treesitter.install')
    if ok then
      treesitter_install.update()
    end
  end,
  },
  { 'n', '<space>ps', packer.status },
}
