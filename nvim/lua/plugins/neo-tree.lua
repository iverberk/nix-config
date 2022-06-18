local neo_tree = require("neo-tree")

vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

neo_tree.setup({
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

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true, silent = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('n', '<leader>n', ':Neotree reveal toggle<cr>')
