return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  keys = {
    { "<C-_>", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<C-p>", function() Snacks.picker.smart() end, desc = "Files" },
    { "<C-g>", function() Snacks.lazygit() end, desc = "Lazygit" },
    { "<C-b>", function() Snacks.picker.buffers() end, desc = "Buffers" },
    { "<leader>p", function() Snacks.picker.projects() end, desc = "Projects", mode = { "n", "v" } },
    { "<leader>gb", function() Snacks.git.blame_line() end, desc = "Git Blame Line" },
    { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit Current File History" },
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
    },

    picker = {
      win = {
        input = {
          keys = {
            ["<Esc>"] = { "close", mode = { "n", "i" } },
          }
        }
      }
    }
  }
}
