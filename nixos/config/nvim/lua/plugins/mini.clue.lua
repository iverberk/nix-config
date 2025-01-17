return {
  'echasnovski/mini.clue',
  config = function()
    local mc = require('mini.clue')

    mc.setup({
      triggers = {
        -- Multicursor trigger
        { mode = 'n', keys = '<C-d>'},


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
        { mode = 'n', keys = '<C-d>n', postkeys = '<C-d>' },
        { mode = 'n', keys = '<C-d>s', postkeys = '<C-d>' },
        { mode = 'n', keys = '<C-d>N', postkeys = '<C-d>' },
        { mode = 'n', keys = '<C-d>S', postkeys = '<C-d>' },
        { mode = 'n', keys = '<C-d>A', postkeys = '<C-d>' },
      }
    })
  end,
  version = '*',
}
