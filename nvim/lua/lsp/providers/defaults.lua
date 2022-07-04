local M = {}

function M.on_attach(client, bufnr)
  local function buf_set_option(...)
    vim.api.nvim_buf_set_option(bufnr, ...)
  end

  if client.name == "tsserver" then
    -- Disable tsserver formatting in favor of null-ls
    client.resolved_capabilities.document_formatting = false
  end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  require('lsp.mappings').init(client, bufnr)
end

M.flags = {
  allow_incremental_sync = true,
  debounce_text_changes = 150,
}

M.root_dir = function(fname)
  local util = require('lspconfig').util
  return util.root_pattern('.git')(fname)
    or util.root_pattern('tsconfig.base.json')(fname)
    or util.root_pattern('package.json')(fname)
    or util.root_pattern('.eslintrc.js')(fname)
    or util.root_pattern('.eslintrc.json')(fname)
    or util.root_pattern('tsconfig.json')(fname)
end

M.capabilities = {}
M.autostart = true
M.single_file_support = true

return M
