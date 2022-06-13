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

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false
  },

  indent = {
    enable = true,
    disable = { 'yaml' }
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm"
    }
  }

})
