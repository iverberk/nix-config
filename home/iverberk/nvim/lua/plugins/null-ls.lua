local null_ls = require("null-ls")

null_ls.setup({
  defaults = {
    debounce = 250,
    save_after_format = true,
    default_timeout = 5000,
  },
  sources = {
    null_ls.builtins.diagnostics.shellcheck.with({ diagnostics_format = "[#{c}] #{m} (#{s})" }),
    null_ls.builtins.diagnostics.yamllint.with({
      args = { "--format", "parsable", "-" }
    }),
    null_ls.builtins.formatting.shfmt,
    null_ls.builtins.formatting.prettier,
    null_ls.builtins.formatting.terraform_fmt,
  }
})
