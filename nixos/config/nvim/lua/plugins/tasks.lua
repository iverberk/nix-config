vim.pack.add({
  "https://github.com/stevearc/overseer.nvim.git",
})

require("overseer").setup({})

vim.api.nvim_create_user_command("OverseerRestartLast", function()
  local overseer = require("overseer")
  local task_list = require("overseer.task_list")
  local tasks = overseer.list_tasks({
    status = {
      overseer.STATUS.SUCCESS,
      overseer.STATUS.FAILURE,
      overseer.STATUS.CANCELED,
    },
    sort = task_list.sort_finished_recently
  })
  if vim.tbl_isempty(tasks) then
    vim.notify("No tasks found", vim.log.levels.WARN)
  else
    local most_recent = tasks[1]
    overseer.run_action(most_recent, "restart")
  end
end, {})

vim.keymap.set("n", "<leader>or", "<cmd>OverseerRun<cr>", { desc = "Run overseer task" })
vim.keymap.set("n", "<leader>ot", "<cmd>OverseerToggle<cr>", { desc = "Toggle overseer tasks" })
vim.keymap.set("n", "<leader>ol", "<cmd>OverseerRestartLast<cr>", { desc = "Restart last tasks" })

vim.pack.add({
  "https://github.com/nvim-neotest/nvim-nio",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/antoinemadec/FixCursorHold.nvim",
  "https://github.com/nvim-neotest/neotest-python.git",
  "https://github.com/nvim-neotest/neotest.git",
})

require("neotest").setup({
  adapters = {
    require("neotest-python")
  }
})

vim.keymap.set("n", "<leader>tr", "<cmd>lua require('neotest').run.run()<cr>", { desc = "Run nearest test" })
vim.keymap.set("n", "<leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<cr>",
  { desc = "Run current file" })
vim.keymap.set("n", "<leader>ta", "<cmd>lua require('neotest').run.run({ suite = true })<cr>", { desc = "Run all tests" })
vim.keymap.set("n", "<leader>ts", "<cmd>lua require('neotest').run.stop()<cr>", { desc = "Stop test" })
vim.keymap.set("n", "<leader>to", "<cmd>lua require('neotest').output.open()<cr>", { desc = "Show test output" })
vim.keymap.set("n", "<leader>tto", "<cmd>lua require('neotest').output_panel.toggle()<cr>",
  { desc = "Toggle test output" })
vim.keymap.set("n", "<leader>tts", "<cmd>lua require('neotest').summary.toggle()<cr>", { desc = "Toggle test summary" })
