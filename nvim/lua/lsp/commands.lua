local util = require('vim.lsp.util')
local augroup_name = 'NvimLspFormat'
local group = vim.api.nvim_create_augroup(augroup_name, { clear = true })

vim.api.nvim_create_autocmd('BufWritePre *', {
  callback = function()
    vim.lsp.buf.formatting_sync()

    -- TODO: Enable on Neovim 0.8
    --
    -- vim.lsp.buf.format({
    --   timeout_ms = 3000,
    --
    --   filter = function(client)
    --     return client.name
    --   end,
    -- })
  end,
  group = group,
  nested = true,
})
