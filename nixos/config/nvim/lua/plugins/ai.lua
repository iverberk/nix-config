vim.pack.add({
  "https://github.com/carlos-algms/agentic.nvim"
})

require("agentic").setup({
  provider = "opencode-acp"
})

vim.keymap.set({ "n", "v" }, "<leader>at", function() require("agentic").toggle() end, { desc = "Toggle Agentic chat" })
vim.keymap.set({ "n", "v" }, "<leader>aa", function() require("agentic").add_selection_or_file_to_context() end,
  { desc = "Add file or selection to Agentic context" })
vim.keymap.set({ "n", "v" }, "<leader>as", function() require("agentic").new_session() end,
  { desc = "New Agentic session" })


vim.pack.add({
  "https://github.com/NickvanDyke/opencode.nvim.git"
})

vim.keymap.set({ "n", "x" }, "<C-a>", function() require("opencode").ask("@this: ", { submit = true }) end,
  { desc = "Ask opencode" })
vim.keymap.set({ "n", "x" }, "<C-x>", function() require("opencode").select() end, { desc = "Execute opencode action…" })
vim.keymap.set({ "n", "t" }, "<C-.>", function() require("opencode").toggle() end, { desc = "Toggle opencode" })

vim.keymap.set({ "n", "x" }, "go", function() return require("opencode").operator("@this ") end,
  { expr = true, desc = "Add range to opencode" })
vim.keymap.set("n", "goo", function() return require("opencode").operator("@this ") .. "_" end,
  { expr = true, desc = "Add line to opencode" })

vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end,
  { desc = "opencode half page up" })
vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end,
  { desc = "opencode half page down" })
