vim.diagnostic.config({
    severity_sort = true,
    virtual_text = false,
    update_in_insert = false,
    underline = false,
    float = {
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
