return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  branch = "main",
  lazy = false,
  build = ":TSUpdate"
}
