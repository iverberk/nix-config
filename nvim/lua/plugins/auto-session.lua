local map = require('utils').map

map('n', '<leader>sl', ':RestoreSession<cr>')
map('n', '<leader>ss', ':SaveSession<cr>')

-- From: https://github.com/rmagatti/auto-session/wiki/Troubleshooting#issue-cmdheight-after-restore-is-incorrect
function _G.close_all_floating_wins()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local config = vim.api.nvim_win_get_config(win)
    if config.relative ~= '' then
      vim.api.nvim_win_close(win, false)
    end
  end
end

require("auto-session").setup({
  pre_save_cmds = { 'Neotree close', _G.close_all_floating_wins },
  post_restore_cmds = { 'Neotree show' },
  auto_session_create_enabled = false,
  auto_save_enabled = true,
  auto_restore_enabled = false,
})
