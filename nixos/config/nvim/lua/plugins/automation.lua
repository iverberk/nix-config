return {
  {
    'stevearc/overseer.nvim',
    opts = {
      templates = { "builtin", "terraform", "python" },
    },
    keys = {
      { "<leader>r", "<cmd>OverseerRun<cr>", desc = "Run a task" },
      { "<leader>R", "<cmd>OverseerRestartLast<cr>", desc = "Restart last task" },
      { "<leader>t", "<cmd>OverseerToggle<cr>", desc = "Open task list" },
    },
    config = function(_, opts)
      require("overseer").setup(opts)

      vim.api.nvim_create_user_command("OverseerRestartLast", function()
        local overseer = require("overseer")
        local tasks = overseer.list_tasks({ recent_first = true })
        if vim.tbl_isempty(tasks) then
          vim.notify("No tasks found", vim.log.levels.WARN)
        else
          overseer.run_action(tasks[1], "restart")
        end
      end, {})
    end,
  }
}
