local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.o.runtimepath = fn.stdpath('data') .. '/site/pack/*/start/*,' .. vim.o.runtimepath
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup(function()

  use { 'wbthomason/packer.nvim' }
  use { 'lewis6991/impatient.nvim' }
  use { 'neovim/nvim-lspconfig', config = [[ require('plugins/nvim-lspconfig') ]] }
  use { 'RRethy/nvim-base16', config = [[ require('plugins/nvim-base16') ]] }
  use { 'nvim-lualine/lualine.nvim', config = [[ require('plugins/lualine') ]], requires = { 'kyazdani42/nvim-web-devicons', opt = true } }
  use { 'hrsh7th/nvim-cmp', config = [[ require('plugins/nvim-cmp') ]], requires = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer" } }
  use { 'hrsh7th/cmp-nvim-lsp-signature-help', requires = { 'hrsh7th/nvim-cmp' } }
  use { 'hrsh7th/cmp-nvim-lsp', requires = { 'hrsh7th/nvim-cmp' } }
  use { 'hrsh7th/vim-vsnip', requires = { 'hrsh7th/nvim-cmp' } }
  use { 'hrsh7th/cmp-vsnip', requires = { 'hrsh7th/nvim-cmp' } }
  use { 'nvim-telescope/telescope.nvim', config = [[ require('plugins/telescope') ]], requires = { 'nvim-lua/plenary.nvim' } }
  use { 'nvim-treesitter/nvim-treesitter', config = [[ require('plugins/nvim-treesitter') ]], run = ':TSUpdate' }
  use { 'jose-elias-alvarez/null-ls.nvim', requires = { "nvim-lua/plenary.nvim" } }
  use { 'ray-x/go.nvim', config = [[ require('plugins/go') ]] }
  use { 'lewis6991/gitsigns.nvim', config = [[ require('plugins/gitsigns') ]], requires = { 'nvim-lua/plenary.nvim' } }
  use { 'rafamadriz/friendly-snippets' }
  use { 'numtostr/comment.nvim', config = [[ require('plugins/comment') ]] } 
  use { 'JoosepAlviste/nvim-ts-context-commentstring', config = [[ require('plugins/nvim-ts-context-commentstring') ]], requires = "nvim-treesitter/nvim-treesitter" }
  use { 'tpope/vim-surround' }
  use { 'akinsho/toggleterm.nvim', config = [[ require('plugins/toggleterm') ]], tag = 'v1.*' }
  use { 'lukas-reineke/indent-blankline.nvim', config = [[ require('plugins/indent-blankline') ]] }
  use { 'akinsho/bufferline.nvim', config = [[ require('plugins/bufferline') ]], requires = 'kyazdani42/nvim-web-devicons', tag = 'v2.*' }
  use { 'famiu/bufdelete.nvim' }
  use { 'knubie/vim-kitty-navigator', run = 'cp ./*.py ~/.config/kitty/' }
  use { 'mfussenegger/nvim-dap', config = [[ require('plugins/nvim-dap') ]] }
  use { 'mfussenegger/nvim-dap-python', config = [[ require('plugins/nvim-dap-python') ]] }
  use { 'nvim-telescope/telescope-dap.nvim' }
  use { 'nvim-neo-tree/neo-tree.nvim', config = [[ require('plugins/neo-tree') ]], branch = "v2.x", requires = { "nvim-lua/plenary.nvim", "kyazdani42/nvim-web-devicons", "MunifTanjim/nui.nvim" } }
  use { 'ggandor/leap.nvim', config = [[ require('plugins/leap') ]] }
  use { 'nvim-neotest/neotest', config = [[ require('plugins/nvim-neotest') ]], requires = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter", "antoinemadec/FixCursorHold.nvim" } }
  use { 'nvim-neotest/neotest-python', requires = { 'nvim-neotest/neotest' } }
  use { 'danymat/neogen', config = [[ require('plugins/neogen') ]], requires = "nvim-treesitter/nvim-treesitter", tag = "*" }
  use { 'unblevable/quick-scope', config = [[ require('plugins/quick-scope') ]] }
  -- use { 'jose-elias-alvarez/typescript.nvim', config = [[ require('plugins/typescript') ]] }

  if packer_bootstrap then
    require('packer').sync()
  end

end)
