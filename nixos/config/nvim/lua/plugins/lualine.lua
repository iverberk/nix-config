return {
  "nvim-lualine/lualine.nvim",
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    theme = "base16-tomorrow-night",
    sections = {
      lualine_x = { "overseer" },
    }
  },
}
