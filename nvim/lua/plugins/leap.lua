local leap = require('leap')

leap.setup {
  case_insensitive = false,
  safe_labels = {}
}

function leap_all_windows()
  leap.leap {
    ['target-windows'] = vim.tbl_filter(
      function (win) return vim.api.nvim_win_get_config(win).focusable end,
      vim.api.nvim_tabpage_list_wins(0)
    )
  }
end

vim.keymap.set('n', "'", leap_all_windows, { silent = true })
