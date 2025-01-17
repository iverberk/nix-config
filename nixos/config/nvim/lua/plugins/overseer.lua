return {
  'stevearc/overseer.nvim',
  opts = {},
  keys = {
    { "<leader>tr", "<cmd>OverseerRun<cr>", "Task Run"},
    { "<leader>tR", "<cmd>OverseerRestartLast<cr>", "Task Restart"},
    { "<leader>tt", "<cmd>OverseerToggle<cr>", "Tasks Run"},
  },
  config = function(_, opts)
    require('overseer').setup(opts)

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
