local nvim_lsp = require("lspconfig")

local opts = { noremap=true, silent=true }

vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  if client.resolved_capabilities.document_formatting then
    vim.cmd([[
      augroup LspFormatting
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
      augroup END
    ]])
  end

end

local null_ls = require("null-ls")

null_ls.setup({
  defaults = {
    debounce = 250,
    save_after_format = true,
    default_timeout = 5000,
  },

  sources = {
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.code_actions.shellcheck,
    null_ls.builtins.diagnostics.shellcheck.with({ diagnostics_format = "[#{c}] #{m} (#{s})" }),
    null_ls.builtins.diagnostics.yamllint.with({args = { "--format", "parsable", "-" }}),
    null_ls.builtins.diagnostics.pylint,
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.fixjson
  },

  on_attach = on_attach
})

nvim_lsp["gopls"].setup({
  capabilities = capabilities,
  on_attach = on_attach,
  cmd = {
    'gopls', 
    '-mode=stdio',
    -- '-remote=auto', 
    -- "-logfile=auto",
    "-debug=:0",
    -- '-remote.debug=:0',
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
    debounce_text_changes = 150
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
})
