local telescope = require('telescope')
local actions = require('telescope.actions')
local map = require('utils').map

map('n', '<C-p>', ':Telescope find_files hidden=true<cr>')
map('n', '<M-g>', ':Telescope live_grep<cr>')
map('n', '<M-o>', ':Telescope oldfiles<cr>')
map('n', '<M-*>', ':Telescope grep_string<cr>')
map('n', '<M-b>', ':Telescope buffers<cr>')
map('n', '<M-r>', ':Telescope registers<cr>')
map('n', '<M-p>', ':Telescope projects<cr>')
map('n', '<M-q>', ':Telescope quickfix<cr>')

telescope.setup({
  defaults = {

    file_ignore_patterns = { "node_modules/.*", "vendor/.*", ".git/*" },

    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
    mappings = {
      i = {
        ["<esc>"] = require('telescope.actions').close,
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        ['<C-q>'] = actions.send_to_qflist + actions.open_qflist
      }
    },
  },

  pickers = {
    oldfiles = {
      theme = "dropdown",
      previewer = false,
      layout_config = { width = 0.8, height = 0.8 }
    },
    find_files = {
      theme = "dropdown",
      previewer = false,
      layout_config = { width = 0.8, height = 0.8 }
    },
    git_files = {
      theme = "dropdown",
      previewer = false,
      layout_config = { width = 0.8, height = 0.8 }
    },
    buffers = {
      sort_lastused = true,
      theme = "dropdown",
      selection_strategy = "closest",
      previewer = false,
      mappings = {
        i = { ["<c-d>"] = actions.delete_buffer },
      },
      layout_config = { width = 0.8, height = 0.8 }
    },
    live_grep = {
      debounce = 100
    }
  }

})

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true, silent = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end


