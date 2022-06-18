local neotest = require('neotest')

neotest.setup({
  adapters = {
    require("neotest-python")({
        -- Extra arguments for nvim-dap configuration
        dap = { justMyCode = false },
        -- Command line arguments for runner
        -- Can also be a function to return dynamic values
        args = {"--log-level", "DEBUG"},
    })
  }
})

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true, silent = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('n', '<leader>to', ":lua require('neotest').output.open({ enter = true })<CR>")
map('n', '<leader>tr', ":lua require('neotest').run.run(vim.fn.expand('%'))<CR>")
map('n', '<leader>td', ":lua require('neotest').run.run({ vim.fn.expand('%'), strategy = 'dap' })<CR>")
map('n', '<leader>tl', ":lua require('neotest').run.run_last()<CR>")
