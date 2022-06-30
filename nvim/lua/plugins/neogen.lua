local neogen = require('neogen')

neogen.setup({
  enabled = true,
  input_after_comment = true,
  languages = {
    python = {
      template = {
        annotation_convention = "google_docstrings",
      },
    },
  },
})

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<Leader>ds", ":lua require('neogen').generate()<CR>", opts)
