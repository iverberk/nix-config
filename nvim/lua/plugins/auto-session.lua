local map = require('utils').map

map('n', '<leader>sl', '<cmd>silent RestoreSession<cr>')
map('n', '<leader>ss', '<cmd>SaveSession<cr>')

require("auto-session").setup({
  pre_save_cmds = { 'NeoTreeClose' },
  post_restore_cmds = { 'NeoTreeReveal' },
  auto_session_create_enabled = true,
  auto_save_enabled = true,
  auto_restore_enabled = false,
})
