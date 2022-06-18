local neogen = require('neogen')

neogen.setup({})

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<Leader>ds", ":lua require('neogen').generate()<CR>", opts)
