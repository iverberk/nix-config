return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    config = function()
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_lspconfig()

      lsp_zero.on_attach(function(client, bufnr)
        lsp_zero.default_keymaps({buffer = bufnr})

        vim.diagnostic.config({
          virtual_text = false
        })
      end)

      require('lspconfig').gopls.setup({})
      require('lspconfig').terraformls.setup({})
      require('lspconfig').pyright.setup({
        handlers = {
          ["textDocument/publishDiagnostics"] = function() end,
        },
      })

      local cmp = require('cmp')
      local cmp_action = require('lsp-zero').cmp_action()
      local cmp_format = require('lsp-zero').cmp_format()

      require('luasnip.loaders.from_vscode').lazy_load()

      cmp.setup({
        preselect = cmp.PreselectMode.None,

        sorting = {
          comparators = {
            -- cmp.config.compare.offset,
            -- cmp.config.compare.exact,
            -- cmp.config.compare.score,
            -- cmp.config.compare.recently_used,
            -- cmp.config.compare.locality,
            -- cmp.config.compare.kind,
            cmp.config.compare.sort_text,
            -- cmp.config.compare.length,
            -- cmp.config.compare.order,
          },
        },

        sources = {
          {name = 'nvim_lsp'},
          {name = 'buffer'},
          {name = 'luasnip'},
        },

        mapping = cmp.mapping.preset.insert({
          ['<CR>'] = cmp.mapping.confirm({select = false}),
          ['<tab>'] = cmp_action.luasnip_supertab(),
          ['<s-tab>'] = cmp_action.luasnip_shift_supertab(),
          ['<C-space>'] = cmp.mapping(function()
            cmp.complete()
          end),
        }),

        formatting = cmp_format,
      })
    end
  },

  {
    'neovim/nvim-lspconfig',
    dependencies = {
      {'hrsh7th/cmp-nvim-lsp'},
    }
  },

  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      {'L3MON4D3/LuaSnip'},
      {'saadparwaiz1/cmp_luasnip'},
      {'rafamadriz/friendly-snippets'},
      {'hrsh7th/cmp-buffer'},
    },
  },
}
