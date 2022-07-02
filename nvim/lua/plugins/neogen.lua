local map = require('utils').map

map("n", "<Leader>ds", ":lua require('neogen').generate()<CR>")

require('neogen').setup({
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
