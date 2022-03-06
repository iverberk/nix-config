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
  use { 'hoob3rt/lualine.nvim', config = [[ require('plugins/lualine') ]], requires = { 'kyazdani42/nvim-web-devicons', opt = true } }
  use { 'kyazdani42/nvim-tree.lua', config = [[ require('plugins/nvim-tree') ]], requires = { 'kyazdani42/nvim-web-devicons' } }
  use { 'hrsh7th/nvim-cmp', config = [[ require('plugins/nvim-cmp') ]], requires = { "hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer" } }
  use { 'hrsh7th/cmp-nvim-lsp', requires = { 'hrsh7th/nvim-cmp' } }
  use { 'hrsh7th/vim-vsnip', requires = { 'hrsh7th/nvim-cmp' } }
  use { 'hrsh7th/cmp-vsnip', requires = { 'hrsh7th/nvim-cmp' } }
  use { 'nvim-telescope/telescope.nvim', config = [[ require('plugins/telescope') ]], requires = { 'nvim-lua/plenary.nvim' } }
  use { 'nvim-treesitter/nvim-treesitter', config = [[ require('plugins/nvim-treesitter') ]], run = ':TSUpdate' }
  use { 'jose-elias-alvarez/null-ls.nvim', requires = { "nvim-lua/plenary.nvim" } }
  use { 'ray-x/go.nvim', config = [[ require('plugins/go') ]] }
  use { 'lewis6991/gitsigns.nvim', config = [[ require('plugins/gitsigns') ]], requires = { 'nvim-lua/plenary.nvim' } }
  use { 'rafamadriz/friendly-snippets' }
  use { 'b3nj5m1n/kommentary' }
  use { 'tpope/vim-surround' }
  use { 'akinsho/toggleterm.nvim', config = [[ require('plugins/toggleterm') ]] }
  use { 'lukas-reineke/indent-blankline.nvim', config = [[ require('plugins/indent-blankline') ]] }
  use { 'akinsho/bufferline.nvim', config = [[ require('plugins/bufferline') ]], requires = 'kyazdani42/nvim-web-devicons' }
  use { 'famiu/bufdelete.nvim' }
  use { 'knubie/vim-kitty-navigator', run = 'cp ./*.py ~/.config/kitty/' }
  use { 'RRethy/nvim-base16', config = [[ require('plugins/nvim-base16') ]] }

  if packer_bootstrap then
    require('packer').sync()
  end

end)
