local nvim_lsp = require("lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting_sync()<CR>', opts)

  local group = vim.api.nvim_create_augroup("Format", { clear = false })

  if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
              -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
              vim.lsp.buf.formatting_sync()
          end,
      })
  end
  
end

nvim_lsp["gopls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = {
    'gopls', 
    '-mode=stdio',
    "-debug=:0",
    "-rpc.trace",
  },
  settings = {
    gopls = {
      analyses = {
        unusedparams = false
      }, 
      staticcheck = true
    },
  },
  flags = {
    allow_incremental_sync = true,
    debounce_text_changes = 250
  }
})

nvim_lsp["terraformls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

nvim_lsp["jsonls"].setup({
  cmd = { "vscode-json-languageserver", "--stdio" },
  capabilities = capabilities,
  on_attach = on_attach,
})

nvim_lsp["yamlls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

nvim_lsp["pyright"].setup({
  capabilities = capabilities,
  on_attach = on_attach,

  settings = {
    python = {
      analysis = {
        typeCheckingMode = "off"
      },
    },
  }
})

nvim_lsp["tsserver"].setup({
  capabilities = capabilities,
  on_attach = on_attach,

  settings = {
    python = {
      analysis = {
        typeCheckingMode = "off"
      },
    },
  }
})
