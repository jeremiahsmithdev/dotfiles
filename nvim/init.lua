-- Set mapleader and maplocalleader before loading plugins
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Bedtime notification (optional)
local hour = os.date("*t").hour
if hour >= 22 then
  vim.notify("It is after 10 PM", vim.log.levels.INFO)
end

-- Load plugins (all configurations are now in plugin specs)
require('plugins')

-- Load personal configurations
require('opts')      -- editor options
require('keys')      -- personal keybindings  
require('style')     -- colorscheme and UI
require('autocmds')  -- autocommands
require('functions') -- custom functions

-- Initialize AI workflow systems
require('config.ai-unified').setup()
require('config.ai-modes').setup()
require('config.ai-shell-integration').setup()

-- Language server configurations (if not handled by plugin specs)
require('language-servers')

-- LSP diagnostic symbols
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN]  = "",
      [vim.diagnostic.severity.HINT]  = "",
      [vim.diagnostic.severity.INFO]  = "",
    },
  },
})

-- Custom filetype detection
vim.filetype.add({
  filename = {
    ["skhdrc"] = "sh",
  }
})


