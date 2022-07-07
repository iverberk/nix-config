local bootstrap = false
local present, packer = pcall(require, 'packer')

if not present then
  local packer_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

  print('Cloning packer..')
  -- remove the dir before cloning
  vim.fn.delete(packer_path, 'rf')
  vim.fn.system({
    'git',
    'clone',
    'https://github.com/wbthomason/packer.nvim',
    '--depth',
    '20',
    packer_path,
  })

  vim.cmd('packadd packer.nvim')
  present, packer = pcall(require, 'packer')

  if present then
    print('Packer cloned successfully.')
    bootstrap = true
  else
    error("Couldn't clone packer !\nPacker path: " .. packer_path .. '\n' .. packer)
  end
end

-- @TODO: check if snapshot exists, if not create it
packer.init({
  -- snapshot = 'packer',
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'rounded' })
    end,
    prompt_border = 'rounded',
  },
  git = {
    clone_timeout = 800, -- Timeout, in seconds, for git clones
  },
  compile_path = vim.fn.stdpath('config') .. '/lua/compiled.lua',
  auto_clean = true,
  compile_on_sync = true,
})

local use = packer.use

return packer.startup(function()

  -- Basics
  use ({
    'wbthomason/packer.nvim',
    'lewis6991/impatient.nvim',
    'direnv/direnv.vim',
    'nathom/filetype.nvim',
    'nvim-lua/plenary.nvim',
    'famiu/bufdelete.nvim',
    'tpope/vim-surround',
  })

  -- Session management
  use { 'rmagatti/auto-session', config = [[ require('plugins/auto-session') ]] }
  use { 'rmagatti/session-lens', config = [[ require('plugins/session-lens') ]], requires = { 'rmagatti/auto-session', 'nvim-telescope/telescope.nvim' } }

  -- Navigation
  use { 'nvim-telescope/telescope.nvim', config = [[ require('plugins/telescope') ]], requires = { 'nvim-lua/plenary.nvim' } }
  use { 'ggandor/leap.nvim', config = [[ require('plugins/leap') ]] }
  use { 'unblevable/quick-scope', config = [[ require('plugins/quick-scope') ]] }
  use { 'knubie/vim-kitty-navigator', run = 'cp ./*.py ~/.config/kitty/' }
  use { 'nvim-neo-tree/neo-tree.nvim', config = [[ require('plugins/neo-tree') ]], branch = "v2.x", event='VimEnter', requires = {
      "nvim-lua/plenary.nvim",
      "kyazdani42/nvim-web-devicons",
      "MunifTanjim/nui.nvim"
    }
  }

  -- UI
  use { 'lewis6991/gitsigns.nvim', config = [[ require('plugins/gitsigns') ]], requires = { 'nvim-lua/plenary.nvim' } }
  use { 'RRethy/nvim-base16', config = [[ require('plugins/nvim-base16') ]] }
  use { 'akinsho/toggleterm.nvim', config = [[ require('plugins/toggleterm') ]], tag = 'v1.*' }
  use { 'akinsho/bufferline.nvim', config = [[ require('plugins/bufferline') ]], requires = 'kyazdani42/nvim-web-devicons', tag = 'v2.*' }
  use { 'lukas-reineke/indent-blankline.nvim', config = [[ require('plugins/indent-blankline') ]] }
  use { 'nvim-lualine/lualine.nvim', config = [[ require('plugins/lualine') ]], after = { 'nvim-base16' }, requires = {
      'kyazdani42/nvim-web-devicons', opt = true
    }
  }

  -- Auto-complete
  use { 'neovim/nvim-lspconfig', config = [[ require('lsp') ]], requires = {
      'b0o/SchemaStore.nvim',
      'williamboman/nvim-lsp-installer',
      { 'jose-elias-alvarez/null-ls.nvim', config = [[ require('lsp/providers/null-ls') ]], after = 'nvim-lspconfig' },
      { 'ray-x/lsp_signature.nvim', config = [[ require('plugins/lsp-signature') ]], after = 'nvim-lspconfig' },
    }
  }

  use { 'hrsh7th/nvim-cmp', config = [[ require('plugins/nvim-cmp') ]], requires = {
      { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-vsnip', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
    }
  }

  use { 'hrsh7th/vim-vsnip', requires = { 'hrsh7th/nvim-cmp' } }
  use { 'rafamadriz/friendly-snippets' }

  -- Language support
  use { 'danymat/neogen', config = [[ require('plugins/neogen') ]], requires = "nvim-treesitter/nvim-treesitter", tag = "*" }
  use { 'nvim-treesitter/nvim-treesitter', config = [[ require('plugins/nvim-treesitter') ]], run = ':TSUpdate' }
  use { 'JoosepAlviste/nvim-ts-context-commentstring', requires = "nvim-treesitter/nvim-treesitter" }
  use { 'numtostr/comment.nvim', config = [[ require('plugins/comment') ]], event = 'BufWinEnter', requires = { 'JoosepAlviste/nvim-ts-context-commentstring' } }
  use { 'ray-x/go.nvim', config = [[ require('plugins/go') ]] }
  use { 'windwp/nvim-ts-autotag', config = [[ require('plugins/nvim-ts-autotag') ]] }
  use { "windwp/nvim-autopairs", config = [[ require('plugins/nvim-autopairs') ]] }

  -- Debugging
  use { 'mfussenegger/nvim-dap', config = [[ require('plugins/nvim-dap') ]] }
  use { 'mfussenegger/nvim-dap-python', config = [[ require('plugins/nvim-dap-python') ]], after = { 'nvim-dap' } }
  use { 'nvim-telescope/telescope-dap.nvim', after = { 'nvim-dap' } }

  -- Testing
  use { 'nvim-neotest/neotest', config = [[ require('plugins/nvim-neotest') ]], requires = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter", "antoinemadec/FixCursorHold.nvim" } }
  use { 'nvim-neotest/neotest-python', requires = { 'nvim-neotest/neotest' } }

  if bootstrap then
    require('packer').sync()
  end

end)
