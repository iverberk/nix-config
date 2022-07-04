local map = require('utils').map

map('n', '<M-s>', ':SearchSession<cr>')

require('session-lens').setup({
  prompt_title = 'Session Picker',
  path_display={'shorten'},
})
