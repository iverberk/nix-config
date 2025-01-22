return {
  "RRethy/base16-nvim",
  priority = 1000,
  config = function()
    vim.cmd([[colorscheme base16-tomorrow-night]])

    vim.api.nvim_set_hl(0, 'MatchParen', { cterm=underline, bold=true, ctermbg=none })
  end
}
