local toggleterm = require('toggleterm')
local Terminal = require('toggleterm.terminal').Terminal

toggleterm.setup({})

function _lazygit_toggle()
  local count = 0

  for char in string.gmatch(vim.api.nvim_eval("sha256(getcwd())"), '%S') do
    count = count + string.byte(char)
  end

  local term = Terminal:new({
    count = count,
    cmd = "lazygit",
    dir = "git_dir",
    direction = "float",
    close_on_exit = true,
    float_opts = {
      border = "double",
    }
  })

  term:toggle()
end

vim.api.nvim_set_keymap("n", "<C-g>", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })
