return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "<leader>/", "<cmd>FzfLua live_grep<cr>", desc = "Grep" },
    { "<leader>:", "<cmd>FzfLua command_history<cr>", desc = "Command History" },
    -- find
    { "<leader>fb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Find Buffers" },
    { "<C-p>", "<cmd>FzfLua files<cr>", desc = "Find Files" },
    { "<leader>fg", "<cmd>FzfLua git_files<cr>", desc = "Find Git Files" },
    { "<leader>fr", "<cmd>FzfLua oldfiles<cr>", desc = "Find Recent" },
    -- git
    { "<leader>gc", "<cmd>FzfLua git_commits<CR>", desc = "Git Commits" },
    { "<leader>gs", "<cmd>FzfLua git_status<CR>", desc = "Git Status" },
    -- search
    { '<leader>s"', "<cmd>FzfLua registers<cr>", desc = "Search Registers" },
    { "<leader>sa", "<cmd>FzfLua autocmds<cr>", desc = "Search Auto Commands" },
    { "<leader>sb", "<cmd>FzfLua grep_curbuf<cr>", desc = "Search Buffer" },
    { "<leader>sc", "<cmd>FzfLua command_history<cr>", desc = "Search Command History" },
    { "<leader>sC", "<cmd>FzfLua commands<cr>", desc = "Search Commands" },
    { "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Search Document Diagnostics" },
    { "<leader>sD", "<cmd>FzfLua diagnostics_workspace<cr>", desc = "Search Workspace Diagnostics" },
    { "<leader>sg", "<cmd>FzfLua live_grep<cr>", desc = "Search via Grep" },
    { "<leader>sh", "<cmd>FzfLua help_tags<cr>", desc = "Search Help Pages" },
    { "<leader>sH", "<cmd>FzfLua highlights<cr>", desc = "Search Highlight Groups" },
    { "<leader>sj", "<cmd>FzfLua jumps<cr>", desc = "Search Jumplist" },
    { "<leader>sk", "<cmd>FzfLua keymaps<cr>", desc = "Search Key Maps" },
    { "<leader>sl", "<cmd>FzfLua loclist<cr>", desc = "Search Location List" },
    { "<leader>sM", "<cmd>FzfLua man_pages<cr>", desc = "Search Man Pages" },
    { "<leader>sm", "<cmd>FzfLua marks<cr>", desc = "Search Jump to Mark" },
    { "<leader>sR", "<cmd>FzfLua resume<cr>", desc = "Resume" },
    { "<leader>sq", "<cmd>FzfLua quickfix<cr>", desc = "Search Quickfix List" },
    { "<leader>sq", "<cmd>FzfLua grep_cword<cr>", desc = "Search Word" },
    { "<leader>sw", "<cmd>FzfLua grep_visual<cr>", mode = "v", desc = "Search Word (Visual)" },
  },
  opts = {
    winopts = {
      height = 0.9,
      width = 0.9,
      border = "single",
      backdrop = 80,
    }
  }
}
