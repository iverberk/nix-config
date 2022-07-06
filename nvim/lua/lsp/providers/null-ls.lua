local defaults = require('lsp.providers.defaults')
local null_ls = require('null-ls')
local merge = require('utils').merge

require('null-ls').setup(merge(defaults, {
  debug = false,
  sources = {
    null_ls.builtins.code_actions.shellcheck,
    null_ls.builtins.code_actions.eslint_d,
    null_ls.builtins.diagnostics.eslint_d,
    null_ls.builtins.diagnostics.shellcheck.with({ diagnostics_format = "[#{c}] #{m} (#{s})" }),
    null_ls.builtins.diagnostics.yamllint.with({args = { "--format", "parsable", "-" }}),
    null_ls.builtins.diagnostics.pylint,
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.prettierd,
    null_ls.builtins.formatting.isort,
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.fixjson
  }
}))
