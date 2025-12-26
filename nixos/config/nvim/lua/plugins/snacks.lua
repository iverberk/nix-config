vim.pack.add({
  "https://github.com/folke/snacks.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
})

local snacks = require("snacks")

snacks.setup({
  animate = { enabled = true },
  bigfile = { enabled = true },
  dashboard = { enabled = false },
  dim = { enabled = true },
  explorer = { enabled = true, replace_netrw = true },
  image = { enabled = false },
  indent = { enabled = true },
  input = { enabled = true },
  layout = { enabled = true },
  notifier = { enabled = true },
  quickfile = { enabled = true },
  scope = { enabled = true },
  scratch = { enabled = false },
  scroll = { enabled = false },
  statuscolumn = { enabled = true },
  terminal = { enabled = true },
  toggle = { enabled = true },
  words = { enabled = false },
  zen = { enabled = false },

  picker = {
    sources = {
      files = {
        hidden = true,
        ignored = true,
        win = {
          input = {
            keys = {
              ["<S-h>"] = "toggle_hidden",
              ["<S-i>"] = "toggle_ignored",
              ["<S-f>"] = "toggle_follow",
              ["<C-y>"] = { "yazi_copy_relative_path", mode = { "n", "i" } },
            },
          },
        },
        exclude = {
          "**/.git/*",
          "**/node_modules/*",
          "**/.yarn/cache/*",
          "**/.yarn/install*",
          "**/.yarn/releases/*",
          "**/.pnpm-store/*",
          "**/.idea/*",
          "**/.DS_Store",
          "build/*",
          "coverage/*",
          "dist/*",
          "hodor-types/*",
          "**/target/*",
          "**/public/*",
          "**/digest*.txt",
          "**/.node-gyp/**",
        },
      },
      grep = {
        hidden = true,
        ignored = true,
        win = {
          input = {
            keys = {
              ["<S-h>"] = "toggle_hidden",
              ["<S-i>"] = "toggle_ignored",
              ["<S-f>"] = "toggle_follow",
            },
          },
        },
        exclude = {
          "**/.git/*",
          "**/node_modules/*",
          "**/.yarn/cache/*",
          "**/.yarn/install*",
          "**/.yarn/releases/*",
          "**/.pnpm-store/*",
          "**/.venv/*",
          "**/.idea/*",
          "**/.DS_Store",
          "**/yarn.lock",
          "build*/*",
          "coverage/*",
          "dist/*",
          "certificates/*",
          "hodor-types/*",
          "**/target/*",
          "**/public/*",
          "**/digest*.txt",
          "**/.node-gyp/**",
        },
      },
      grep_buffers = {},
      explorer = {
        hidden = true,
        ignored = true,
        supports_live = true,
        auto_close = true,
        diagnostics = true,
        diagnostics_open = false,
        focus = "list",
        follow_file = true,
        git_status = true,
        git_status_open = false,
        git_untracked = true,
        jump = { close = true },
        tree = true,
        watch = true,
        exclude = {
          ".git",
          ".pnpm-store",
          ".venv",
          ".DS_Store",
          "**/.node-gyp/**",
        },
      },
    },
  },
})

vim.api.nvim_create_autocmd("User", {
  pattern = "VeryLazy",
  callback = function()
    snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
    snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
    snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
    snacks.toggle.diagnostics():map("<leader>ud")
    snacks.toggle.line_number():map("<leader>ul")
    snacks.toggle
        .option("conceallevel",
          { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = "Conceal Level" })
        :map("<leader>uc")
    snacks.toggle
        .option("showtabline", { off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = "Tabline" })
        :map("<leader>uA")
    snacks.toggle.treesitter():map("<leader>uT")
    snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
    snacks.toggle.dim():map("<leader>uD")
    snacks.toggle.animate():map("<leader>ua")
    snacks.toggle.indent():map("<leader>ug")
    snacks.toggle.scroll():map("<leader>uS")
    snacks.toggle.profiler():map("<leader>dpp")
    snacks.toggle.profiler_highlights():map("<leader>dph")
    snacks.toggle.zoom():map("<leader>wm"):map("<leader>uZ")
    snacks.toggle.zen():map("<leader>uz")
  end,
})

-- stylua: ignore start
local keymaps = {
  { "<leader>l",       function() vim.cmd("Lazy") end,                 desc = "Open Lazy tab", },
  -- Top Pickers & Explorer
  { "<leader><space>", function() snacks.picker.smart() end,           desc = "Smart Find Files" },
  { "<leader>/",       function() snacks.picker.grep() end,            desc = "Grep" },
  { "<leader>:",       function() snacks.picker.command_history() end, desc = "Command History" },
  { "<leader>n",       function() snacks.picker.notifications() end,   desc = "Notification History" },
  { "<leader>e",       function() snacks.explorer() end,               desc = "File Explorer" },
  {
    "<leader>,",
    function()
      snacks.picker.buffers({
        win = {
          input = {
            keys = {
              ["dd"] = "bufdelete",
              ["<c-d>"] = { "bufdelete", mode = { "n", "i" } },
            },
          },
          list = { keys = { ["dd"] = "bufdelete" } },
        },
      })
    end,
    desc = "Buffers",
  },
  -- Find
  { "<leader>fb", function() snacks.picker.buffers() end,                                 desc = "Buffers" },
  { "<leader>fc", function() snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
  { "<leader>ff", function() snacks.picker.files() end,                                   desc = "Find Files" },
  { "<leader>fg", function() snacks.picker.git_files() end,                               desc = "Find Git Files" },
  { "<leader>fp", function() snacks.picker.projects() end,                                desc = "Projects" },
  { "<leader>fr", function() snacks.picker.recent() end,                                  desc = "Recent" },

  -- Git
  { "<leader>gb", function() snacks.picker.git_branches() end,                            desc = "Git Branches" },
  { "<leader>gl", function() snacks.picker.git_log() end,                                 desc = "Git Log" },
  { "<leader>gL", function() snacks.picker.git_log_line() end,                            desc = "Git Log Line" },
  { "<leader>gs", function() snacks.picker.git_status() end,                              desc = "Git Status" },
  { "<leader>gS", function() snacks.picker.git_stash() end,                               desc = "Git Stash" },
  { "<leader>gd", function() snacks.picker.git_diff() end,                                desc = "Git Diff (Hunks)" },
  { "<leader>gD", function() snacks.picker.git_diff({ base = "origin" }) end,             desc = "Git Diff (origin)" },
  { "<leader>gf", function() snacks.picker.git_log_file() end,                            desc = "Git Log File" },

  -- Grep
  { "<leader>sb", function() snacks.picker.lines() end,                                   desc = "Buffer Lines" },
  { "<leader>sB", function() snacks.picker.grep_buffers() end,                            desc = "Grep Open Buffers" },
  { "<leader>sg", function() snacks.picker.grep() end,                                    desc = "Grep" },
  { "<leader>sw", function() snacks.picker.grep_word() end,                               desc = "Visual selection or word", mode = { "n", "x" } },

  -- Search
  { '<leader>s"', function() snacks.picker.registers() end,                               desc = "Registers" },
  { '<leader>s/', function() snacks.picker.search_history() end,                          desc = "Search History" },
  { "<leader>sa", function() snacks.picker.autocmds() end,                                desc = "Autocmds" },
  { "<leader>sb", function() snacks.picker.lines() end,                                   desc = "Buffer Lines" },
  { "<leader>sc", function() snacks.picker.command_history() end,                         desc = "Command History" },
  { "<leader>sC", function() snacks.picker.commands() end,                                desc = "Commands" },
  { "<leader>sd", function() snacks.picker.diagnostics() end,                             desc = "Diagnostics" },
  { "<leader>sD", function() snacks.picker.diagnostics_buffer() end,                      desc = "Buffer Diagnostics" },
  { "<leader>sH", function() snacks.picker.highlights() end,                              desc = "Highlights" },
  { "<leader>si", function() snacks.picker.icons() end,                                   desc = "Icons" },
  { "<leader>sj", function() snacks.picker.jumps() end,                                   desc = "Jumps" },
  { "<leader>sk", function() snacks.picker.keymaps() end,                                 desc = "Keymaps" },
  { "<leader>sl", function() snacks.picker.loclist() end,                                 desc = "Location List" },
  { "<leader>sm", function() snacks.picker.marks() end,                                   desc = "Marks" },
  { "<leader>sM", function() snacks.picker.man() end,                                     desc = "Man Pages" },
  { "<leader>sp", function() snacks.picker.lazy() end,                                    desc = "Search for Plugin Spec" },
  { "<leader>sq", function() snacks.picker.qflist() end,                                  desc = "Quickfix List" },
  { "<leader>sR", function() snacks.picker.resume() end,                                  desc = "Resume" },
  { "<leader>su", function() snacks.picker.undo() end,                                    desc = "Undo History" },
  { "<leader>uC", function() snacks.picker.colorschemes() end,                            desc = "Colorschemes" },

  -- LSP
  { "gd",         function() snacks.picker.lsp_definitions() end,                         desc = "Goto Definition" },
  { "gD",         function() snacks.picker.lsp_declarations() end,                        desc = "Goto Declaration" },
  { "gr",         function() snacks.picker.lsp_references() end,                          nowait = true,                     desc = "References" },
  { "gI",         function() snacks.picker.lsp_implementations() end,                     desc = "Goto Implementation" },
  { "gy",         function() snacks.picker.lsp_type_definitions() end,                    desc = "Goto T[y]pe Definition" },
  { "<leader>ss", function() snacks.picker.lsp_symbols() end,                             desc = "LSP Symbols" },
  { "<leader>sS", function() snacks.picker.lsp_workspace_symbols() end,                   desc = "LSP Workspace Symbols" },
  { "gai",        function() snacks.picker.lsp_incoming_calls() end,                      desc = "C[a]lls Incoming",         has = "callHierarchy/incomingCalls" },
  { "gao",        function() snacks.picker.lsp_outgoing_calls() end,                      desc = "C[a]lls Outgoing",         has = "callHierarchy/outgoingCalls" },

  -- Buffers
  { "<leader>bd", function() snacks.bufdelete() end,                                      desc = "Delete buffer",            mode = { "n" }, },
  { "<leader>bo", function() snacks.bufdelete.other() end,                                desc = "Delete other buffers",     mode = { "n" }, },

  -- Terminal
  { "<leader>fT", function() snacks.terminal() end,                                       desc = "Terminal (cwd)",           mode = "n", },
  { "<leader>ft", function() snacks.terminal(nil, { cwd = vim.fn.getcwd() }) end,         desc = "Terminal (Root Dir)",      mode = "n", },
  { "<c-:>",      function() snacks.terminal(nil, { cwd = vim.fn.getcwd() }) end,         desc = "Terminal (Root Dir)",      mode = "n", },
  { "<c-/>",      function() snacks.terminal() end,                                       desc = "Toggle Terminal" },
  { "<c-_>",      function() snacks.terminal(nil, { cwd = vim.fn.getcwd() }) end,         desc = "which_key_ignore",         mode = "n", },

  -- Other
  { "<leader>z",  function() snacks.zen() end,                                            desc = "Toggle Zen Mode" },
  { "<leader>Z",  function() snacks.zen.zoom() end,                                       desc = "Toggle Zoom" },
  { "<leader>.",  function() snacks.scratch() end,                                        desc = "Toggle Scratch Buffer" },
  { "<leader>S",  function() snacks.scratch.select() end,                                 desc = "Select Scratch Buffer" },
  { "<leader>n",  function() snacks.notifier.show_history() end,                          desc = "Notification History" },
  { "<leader>bd", function() snacks.bufdelete() end,                                      desc = "Delete Buffer" },
  { "<leader>cR", function() snacks.rename.rename_file() end,                             desc = "Rename File" },
  { "<leader>gB", function() snacks.gitbrowse() end,                                      desc = "Git Browse",               mode = { "n", "v" } },
  { "<leader>gg", function() snacks.lazygit() end,                                        desc = "Lazygit" },
  { "<leader>un", function() snacks.notifier.hide() end,                                  desc = "Dismiss All Notifications" },
  { "<c-_>",      function() snacks.terminal() end,                                       desc = "which_key_ignore" },
  { "]]",         function() snacks.words.jump(vim.v.count1) end,                         desc = "Next Reference",           mode = { "n", "t" } },
  { "[[",         function() snacks.words.jump(-vim.v.count1) end,                        desc = "Prev Reference",           mode = { "n", "t" } },
}
-- stylua: ignore end
for _, map in ipairs(keymaps) do
  local opts = { desc = map.desc }
  if map.silent ~= nil then
    opts.silent = map.silent
  end
  if map.noremap ~= nil then
    opts.noremap = map.noremap
  else
    opts.noremap = true
  end
  if map.expr ~= nil then
    opts.expr = map.expr
  end

  local mode = map.mode or "n"
  vim.keymap.set(mode, map[1], map[2], opts)
end
