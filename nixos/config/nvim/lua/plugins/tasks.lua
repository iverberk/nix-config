vim.pack.add({
  "https://github.com/stevearc/overseer.nvim.git",
})

require("overseer").setup({})

vim.keymap.set("n", "<leader>tr", "<cmd>OverseerRun<cr>", { desc = "Run task" })
vim.keymap.set("n", "<leader>tt", "<cmd>OverseerToggle<cr>", { desc = "Toggle tasks" })
