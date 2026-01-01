vim.pack.add({
  "https://github.com/folke/flash.nvim",
})

local flash = require("flash")
flash.setup({
  modes = {
    -- Enhanced f, t, F, T motions
    char = {
      enabled = false,
      jump_labels = true,
    },
  },
})

-- Keymaps
-- stylua: ignore start
vim.keymap.set({ "n", "x", "o" }, "s", function() flash.jump() end, { desc = "Flash" })
vim.keymap.set({ "n", "x", "o" }, "S", function() flash.treesitter() end, { desc = "Flash Treesitter" })
vim.keymap.set("o", "r", function() flash.remote() end, { desc = "Remote Flash" })
vim.keymap.set({ "x", "o" }, "R", function() flash.treesitter_search() end, { desc = "Treesitter Search" })
vim.keymap.set("c", "<c-s>", function() flash.toggle() end, { desc = "Toggle Flash Search" })
-- stylua: ignore end

vim.pack.add({
  "https://github.com/mrjones2014/smart-splits.nvim",
})

require("smart-splits").setup({
  multiplexer_integration = "wezterm"
})

vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)
vim.keymap.set('n', '<C-\\>', require('smart-splits').move_cursor_previous)
