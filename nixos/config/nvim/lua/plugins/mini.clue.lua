return {
  'echasnovski/mini.clue',
  config = function()
    local mc = require('mini.clue')

    mc.setup({
      triggers = {
        -- Multicursor trigger
        { mode = 'n', keys = '<leader>d'},
        { mode = 'v', keys = '<leader>d'},

        -- Leader triggers
        { mode = 'n', keys = '<Leader>' },
        { mode = 'x', keys = '<Leader>' },

        -- Built-in completion
        { mode = 'i', keys = '<C-x>' },

        -- `g` key
        { mode = 'n', keys = 'g' },
        { mode = 'x', keys = 'g' },

        -- Marks
        { mode = 'n', keys = "'" },
        { mode = 'n', keys = '`' },
        { mode = 'x', keys = "'" },
        { mode = 'x', keys = '`' },

        -- Registers
        { mode = 'n', keys = '"' },
        { mode = 'x', keys = '"' },
        { mode = 'i', keys = '<C-r>' },
        { mode = 'c', keys = '<C-r>' },

        -- Window commands
        { mode = 'n', keys = '<C-w>' },

        -- `z` key
        { mode = 'n', keys = 'z' },
        { mode = 'x', keys = 'z' },
      },

      clues = {
        mc.gen_clues.builtin_completion(),
        mc.gen_clues.g(),
        mc.gen_clues.marks(),
        mc.gen_clues.registers(),
        mc.gen_clues.windows(),
        mc.gen_clues.z(),

        -- Multicursor
        { mode = 'n', keys = '<leader>dn', postkeys = '<leader>d' },
        { mode = 'n', keys = '<leader>ds', postkeys = '<leader>d' },
        { mode = 'n', keys = '<leader>dN', postkeys = '<leader>d' },
        { mode = 'n', keys = '<leader>dS', postkeys = '<leader>d' },
        { mode = 'n', keys = '<leader>da', postkeys = '<leader>d' },
        { mode = 'n', keys = '<leader>dh', postkeys = '<leader>d' },
        { mode = 'n', keys = '<leader>dj', postkeys = '<leader>d' },
        { mode = 'n', keys = '<leader>dJ', postkeys = '<leader>d' },
        { mode = 'n', keys = '<leader>dk', postkeys = '<leader>d' },
        { mode = 'n', keys = '<leader>dK', postkeys = '<leader>d' },
        { mode = 'n', keys = '<leader>dl', postkeys = '<leader>d' },
        { mode = 'n', keys = '<leader>dt', postkeys = '<leader>d' },
        { mode = 'n', keys = '<leader>dd', postkeys = '<leader>d' },
      }
    })
  end,
  version = '*',
}
