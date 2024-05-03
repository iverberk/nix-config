-- Navigation
vim.keymap.set('n', '<C-h>', ":NavigatorLeft<cr>", { desc = "Move to left split", silent = true})
vim.keymap.set('n', '<C-j>', ":NavigatorDown<cr>", { desc = "Move to below split", silent = true})
vim.keymap.set('n', '<C-k>', ":NavigatorUp<cr>", { desc = "Move to above split", silent = true})
vim.keymap.set('n', '<C-l>', ":NavigatorRight<cr>", { desc = "Move to right split", silent = true})

-- better up/down
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move Lines
vim.keymap.set("n", "<M-j>", ":m .+1<cr>==", { desc = "Move down" })
vim.keymap.set("v", "<M-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
vim.keymap.set("i", "<M-j>", "<Esc>:m .+1<cr>==gi", { desc = "Move down" })
vim.keymap.set("n", "<M-k>", ":m .-2<cr>==", { desc = "Move up" })
vim.keymap.set("v", "<M-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })
vim.keymap.set("i", "<M-k>", "<Esc>:m .-2<cr>==gi", { desc = "Move up" })

-- Clear search with <esc>
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- lazy
vim.keymap.set("n", "<leader>l", "<cmd>:Lazy<cr>", { desc = "Lazy" })

-- open lists
vim.keymap.set("n", "<leader>ol", "<cmd>lopen<cr>", { desc = "Open Location List" })
vim.keymap.set("n", "<leader>oq", "<cmd>copen<cr>", { desc = "Open Quickfix List" })

-- escaping
vim.keymap.set('i', 'jj', '<Esc>', { desc = "Exit insert mode" })

-- quit
vim.keymap.set('n', '<leader>q', "<cmd>q<cr>", { desc = "Quit" })

-- save file
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- lazygit
vim.keymap.set("n", "<C-g>", "<cmd>lua _lazygit_toggle()<cr>", { desc = "Lazygit" })
