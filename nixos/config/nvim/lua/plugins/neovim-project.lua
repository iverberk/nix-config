return {
  "coffebar/neovim-project",
  opts = {
    projects = {
      "~/code/*",
      "~/code/*/*",
      "~/nix-config",
    },
    picker = {
      type = "fzf-lua",
    },
    last_session_on_startup = false,
    dashboard_mode = true,
  },
  keys = {
    { "<leader>p", "<cmd>NeovimProjectDiscover<cr>", desc = "Find Projects" },
  },
  init = function()
    -- enable saving the state of plugins in the session
    vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
  end,
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "Shatur/neovim-session-manager" },
  },
  lazy = false,
  priority = 100,
}
