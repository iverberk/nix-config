vim.api.nvim_set_keymap("n", "<M-l>", ":BufferLineCycleNext<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<M-h>", ":BufferLineCyclePrev<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<M-w>", ":Bdelete<CR>", { noremap = true, silent = true })

require("bufferline").setup {
  options = {
    numbers = "none",
    indicator_icon = "│",
    offsets = {
      {
        filetype = "neo-tree",
        text = "File Explorer",
      }
    },
    show_buffer_icons = false,
    show_buffer_close_icons = false,
    show_close_icon = false,
    always_show_bufferline = false,
    separator_style = 'slant',
  },
}
