return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  keys = {
    { "<leader>gB", function() Snacks.gitbrowse() end, desc = "Git Browse", mode = { "n", "v" } },
    { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
    { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History" },
    { "<C-g>", function() Snacks.lazygit() end, desc = "Lazygit" },
    { "<leader>gl", function() Snacks.lazygit.log() end, desc = "Lazygit Log (cwd)" },
  },
  opts = {
    styles = {
      float = {
        border = "single",
        position = "float",
        backdrop = 80,
        height = 0.9,
        width = 0.9,
        zindex = 50,
      }
    }
  }
}
