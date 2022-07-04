local lualine = require('lualine')

lualine.setup({
  options = {
    theme = 'base16',
  },
  extensions = { 'neo-tree' },
  sections = {
    lualine_x = {
      require('auto-session-library').current_session_name,
      'encoding'
    }
  }
})
