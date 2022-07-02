local merge = require('utils').merge
local lsp_installer = require('nvim-lsp-installer')

local language_servers = {
  'jsonls',
  'terraformls',
  'yamlls',
  'pyright',
  'tsserver',
  'gopls',
}

lsp_installer.settings({
  ui = {
    keymaps = {
      toggle_server_expand = 'i',
      install_server = '<CR>',
      update_server = 'u',
      uninstall_server = 'x',
    },
  },
})

local lsp_installer_servers = require('nvim-lsp-installer.servers')
for _, language_server in pairs(language_servers) do
  local ok, server = lsp_installer_servers.get_server(language_server)
  if ok then
    if not server:is_installed() then
      server:install()
    end
  end
end

local defaults = require('lsp.providers.defaults')

lsp_installer.on_server_ready(function(server)
  opts = merge(defaults, require(string.format('lsp.providers.%s', server.name)))

  server:setup(opts)
  vim.cmd([[ do User LspAttachBuffers ]])
end)
