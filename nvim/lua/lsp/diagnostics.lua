local map = require('utils').map

map('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>')
map('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
map('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>')

vim.diagnostic.config({
    signs = true,
    severity_sort = true,
    update_in_insert = false,
    underline = false,
    virtual_text = false,
    float = {
      focusable = false,
      border = 'rounded',
      source = 'always',
      header = '',
      prefix = '',
    }
  })

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }

for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
