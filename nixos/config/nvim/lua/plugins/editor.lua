return {

  { 
    'echasnovski/mini.surround', 
    version = '*' ,
    opts = {

      mappings = {
        add = 'ys',
        delete = 'ds',
        replace = 'cs',
        find = '',
        find_left = '',
        highlight = '',
        update_n_lines = '',

        suffix_last = '',
        suffix_next = '',
      }
    }
  },

  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    opts = {
      enable_autocmd = false,
    }
  },

  {
    "echasnovski/mini.comment",
    event = "BufRead",
    opts = {
      options = {
        custom_commentstring = function()
          return require('ts_context_commentstring.internal').calculate_commentstring() or vim.bo.commentstring
        end,
      },
    },
  },

  {
    'akinsho/toggleterm.nvim',
    event = 'VeryLazy',
    config = function()

      require('toggleterm').setup({})

      function _lazygit_toggle()
        local count = 0

        for char in string.gmatch(vim.api.nvim_eval("sha256(getcwd())"), '%S') do
          count = count + string.byte(char)
        end

        local term = require('toggleterm.terminal').Terminal:new({
          count = count,
          cmd = "lazygit",
          dir = "git_dir",
          autochdir = true,
          direction = "float",
          close_on_exit = true,
        })

        term:toggle()
      end
    end
  },

  {
    "NeogitOrg/neogit",
    config = true
  },

  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        python = { "ruff_fix", "ruff_format" },
      },

      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    }
  },

  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        python = { "ruff" },
      },
    },
    config = function(_, opts)
      local lint = require("lint")

      lint.linters_by_ft = opts.linters_by_ft

      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end

  },

  {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      local configs = require("nvim-treesitter.configs")

      configs.setup({
        highlight = { enable = true },
        indent = { enable = true },
        ensure_installed = {
          "bash",
          "hcl",
          "json",
          "python",
          "yaml",
          "go",
          "markdown_inline",
          "lua",
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
        textobjects = {
          move = {
            enable = true,
            goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
            goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer" },
            goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
            goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer" },
          }
        }
      })
    end
  },

  {
    "nvim-pack/nvim-spectre",
    build = false,
    cmd = "Spectre",
    opts = { open_cmd = "noswapfile vnew" },
    -- stylua: ignore
    keys = {
      { "<leader>sr", function() require("spectre").open() end, desc = "Replace in Files (Spectre)" },
    },
  },
    
}
