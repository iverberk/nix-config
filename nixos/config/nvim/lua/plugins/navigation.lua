return {

  {
    'numtostr/Navigator.nvim',
    cmd = {
      'NavigatorLeft',
      'NavigatorRight',
      'NavigatorUp',
      'NavigatorDown',
    },
    opts = {
      auto_save = nil,
      disable_on_zoom = false,
      mux = 'auto'
    }
  },

  {
    "folke/flash.nvim",
    opts = {},
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },

  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    config = function()
      local actions = require('telescope.actions')

      -- Apply the settings to Telescope
      require("telescope").setup({
        results_prompt = true,
        extensions = {
          file_browser = {
            hidden = {
              file_browser = true,
              folder_browser = true,
            },
            no_ignore = true,
          },
        },
        defaults = {
          path_display = { "absolute" }, -- Use absolute paths in the file browser
          previewer = false,
          initial_mode = "insert",
          vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '-uu'
          },
          file_ignore_patterns = { "node_modules", "vendor", ".git", ".direnv" },
          mappings = {
            i = {
              ["<esc>"] = actions.close,
              ['<C-j>'] = actions.move_selection_next,
              ['<C-k>'] = actions.move_selection_previous,
              ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
            }
          },

        },
      })

      require("telescope").load_extension("file_browser")
    end,
    keys = {
      { "<leader>,", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Switch Buffer" },
      { "<leader>g", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
      { "<leader>o", "<cmd>Telescope oldfiles<cr>", desc = "Recent files" },
      { "<leader>p", "<cmd>Telescope neovim-project history<cr>", desc = "Recent projects" },
      { "<leader>f", "<cmd>Telescope git_files show_untracked=true<cr>", desc = "Find Files" },
      { "<leader>F", "<cmd>Telescope find_files hidden=true no_ignore=true no_ignore_parent=true<cr>", desc = "Find Files" },
      { "<leader>n", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", desc = "File Browser" },
    },
  },

  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { 
      "nvim-telescope/telescope.nvim", 
      "nvim-lua/plenary.nvim" 
    }
  },

  {
    "coffebar/neovim-project",
    opts = {
      projects = {
        "/home/iverberk/code/*",
      },
      last_session_on_startup = false,
    },
    init = function()
      vim.opt.sessionoptions:append("globals")
    end,
    dependencies = {
      { "Shatur/neovim-session-manager" },
    },
    lazy = false,
    priority = 100,
  },

  {
    "folke/trouble.nvim",
    branch = "dev",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
    opts = {
      auto_close = true,
    },
  }

}
