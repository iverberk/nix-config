return {

  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    config = true,
  },

  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {} -- this is equalent to setup({}) function
  },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-neotest/neotest-go",
    },
    opts = {
      adapters = {
        ["neotest-go"] = {
          args = { "" }
        }
      },
      status = { virtual_text = true },
      output = { open_on_run = true },
    },
  }

}
