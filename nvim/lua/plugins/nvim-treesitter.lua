require('nvim-treesitter.configs').setup({
  ensure_installed = {
    "gomod",
    "go",
    "nix",
    "comment",
    "bash",
    "hcl",
    "json5",
    "vim",
    "lua",
    "python",
    "dockerfile",
    "yaml",
    "javascript",
    "typescript",
    "json",
    "css",
    "html"
  },

  context_commentstring = {
    enable = true,
    enable_autocmd = false
  },

  highlight = {
    enable = true,
    use_languagetree = true
  },

  indent = {
    enable = true,
  },

  refactor = {
    highlight_definitions = { enable = true },
    highlight_current_scope = { enable = false },
  },

})
