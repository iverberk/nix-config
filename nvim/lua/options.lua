local g = vim.g
local o = vim.opt
local bo = vim.bo
local wo = vim.wo

g.mapleader = ' '

o.shortmess:append({ I = true })
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
o.completeopt = 'menu,menuone,noselect'
o.signcolumn = 'yes'
o.so = 999
o.fillchars = { eob = " ", vert = '▎' }
bo.smartindent = true
bo.swapfile = false
wo.number = true
wo.wrap = false

if vim.fn.has('wsl') then
  o.clipboard = "unnamedplus"
end

vim.diagnostic.config {
  virtual_text = false,
  signs = true,
  underline = false,
  update_in_insert = true,
}
