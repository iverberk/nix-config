local map = require ('utils').map

map("n", "<M-l>", ":BufferLineCycleNext<CR>")
map("n", "<M-h>", ":BufferLineCyclePrev<CR>")
map("n", "<M-w>", ":Bdelete<CR>")

require("bufferline").setup({
  options = {
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
})
