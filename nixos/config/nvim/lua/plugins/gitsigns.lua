return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {},
  keys = {
    { "]c", function() require("gitsigns").next_hunk() end, desc = "Next Git hunk" },
    { "[c", function() require("gitsigns").prev_hunk() end, desc = "Prev Git hunk" },
    { "<leader>hp", function() require("gitsigns").preview_hunk() end, desc = "Preview hunk" },
  },
}
