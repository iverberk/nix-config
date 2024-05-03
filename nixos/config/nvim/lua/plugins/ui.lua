return {

  {
    'RRethy/nvim-base16',
    lazy = false,
    priority = 1000,
    config = function()
      require('base16-colorscheme').setup("tomorrow-night", {
        telescope_borders = true
      })

      vim.cmd('colorscheme base16-tomorrow-night')

      -- Nicer matching pairs highlight
      vim.api.nvim_set_hl(0, 'MatchParen', { cterm=underline, bold=true, ctermbg=none })
    end
  },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = {
        theme = 'base16',
      },
      sections = {
        lualine_x = { 
          "overseer",
        },
      },
    }
  },

}
