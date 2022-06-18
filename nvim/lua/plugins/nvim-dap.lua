local dap = require('dap')

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true, silent = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('n', '<F5>', ":lua require'dap'.continue()<CR>")
map('n', '<F6>', ":lua require'dap'.step_into()<CR>")
map('n', '<F7>', ":lua require'dap'.step_over()<CR>")
map('n', '<F8>', ":lua require'dap'.step_out()<CR>")
map('n', '<F9>', ":lua require'dap'.terminate()<CR>")
map('n', '<leader>dr', ":lua require'dap'.repl_open()<CR>")
map('n', '<leader>dl', ":lua require'dap'.run_last()<CR>")
map('n', '<leader>b', ":lua require'dap'.toggle_breakpoint()<CR>")
map('n', '<leader>B', ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
map('n', '<leader>lp', ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>")
