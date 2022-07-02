local map = require('utils').map

map('n', '<leader>n', ':Neotree reveal toggle<cr>')

vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

require('neo-tree').setup({
  close_if_last_window = true,
  popup_border_style = "rounded",
  filesystem = {
    filtered_items = {
      visible = false,
      hide_dotfiles = false,
      hide_gitignored = true,
      hide_hidden = false,
    },
    follow_current_file = true,
    group_empty_dirs = false,
    use_libuv_file_watcher = true
  }
})
