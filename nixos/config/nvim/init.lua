vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("options")
require("keymaps")
require("commands")
require("diagnostics")
require("lsp")

require("plugins.colorscheme")
require("plugins.keys")
require("plugins.git")
require("plugins.treesitter")
require("plugins.autocomplete")
require("plugins.snacks")
require("plugins.formatting")
require("plugins.navigation")
require("plugins.editing")
require("plugins.visualisation")
require("plugins.tasks")
require("plugins.ai")
