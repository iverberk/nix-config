return {
  'Shatur/neovim-session-manager',
  config = function(opts)
    require('session_manager').setup({opts})
  end,
}
