local g = vim.g
local o = vim.opt
local bo = vim.bo
local wo = vim.wo

o.sessionoptions = 'buffers,curdir,folds,tabpages,winsize'
o.lazyredraw = true
o.list = true
o.termguicolors = true
o.syntax = 'on'
g.noshowmode = true
o.errorbells = false
o.smartcase = true
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.showmode = false
o.backup = false
o.undodir = vim.fn.stdpath('config') .. '/undodir'
o.undofile = true
o.incsearch = true
o.hidden = true
o.completeopt = {'menu', 'menuone', 'noselect'}
o.shortmess:append({ I = true })
o.signcolumn = 'yes'
o.so = 999
o.redrawtime = 1500
o.timeoutlen = 250
o.ttimeoutlen = 10
o.updatetime = 100
o.fillchars = { eob = " ", vert = '▎' }
o.list = false

bo.smartindent = true
bo.swapfile = false
wo.number = true
wo.wrap = false
