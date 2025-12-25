return {
  'nvim-mini/mini.ai',
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects"
  },
  version = false,
  config = function()
    local ai = require("mini.ai")

    ai.setup({
      n_lines = 500,

      custom_textobjects = {
        f = ai.gen_spec.treesitter({
          a = "@function.outer",
          i = "@function.inner",
        }),

        c = ai.gen_spec.treesitter({
          a = "@class.outer",
          i = "@class.inner",
        }),

        l = ai.gen_spec.treesitter({
          a = "@loop.outer",
          i = "@loop.inner",
        }),

        i = ai.gen_spec.treesitter({
          a = "@conditional.outer",
          i = "@conditional.inner",
        }),
      },
    })
  end,
}
