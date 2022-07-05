-- Impatient needs to load first
local ok, _ = pcall(require, 'impatient')
if not ok then
  vim.notify('impatient.nvim not installed', vim.log.levels.WARN, {})
end

vim.g.mapleader = ' '

local mods = {
  'compiled',
  'options',
  'plugins',
  'commands',
  'mappings',
}

for _, mod in ipairs(mods) do
  local ok, err = pcall(require, mod)
  if mod == 'compiled' and not ok then
    vim.notify('Please run: PackerCompile', vim.log.levels.WARN, {})
  elseif not ok then
    error(('Error loading %s...\n\n%s'):format(mod, err))
  end
end
