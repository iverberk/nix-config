-- Navigation
vim.keymap.set('n', '<C-h>', ":NavigatorLeft<cr>", { desc = "Move to left split", silent = true})
vim.keymap.set('n', '<C-j>', ":NavigatorDown<cr>", { desc = "Move to below split", silent = true})
vim.keymap.set('n', '<C-k>', ":NavigatorUp<cr>", { desc = "Move to above split", silent = true})
vim.keymap.set('n', '<C-l>', ":NavigatorRight<cr>", { desc = "Move to right split", silent = true})

-- better up/down
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Clear search with <esc>
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- open lists
vim.keymap.set("n", "<leader>ll", "<cmd>lopen<cr>", { desc = "List Location" })
vim.keymap.set("n", "<leader>lq", "<cmd>copen<cr>", { desc = "List Quickfix" })

-- escaping
vim.keymap.set('i', 'jj', '<Esc>', { desc = "Exit insert mode" })
vim.keymap.set('i', '<C-l>', '<Esc>A', { desc = "Append to end of line" })

-- quit
vim.keymap.set('n', '<leader>q', "<cmd>q<cr>", { desc = "Quit" })

-- save file
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
