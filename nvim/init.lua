local hour = os.date("*t").hour
if hour >= 22 then
  vim.notify("It is after 10 PM", vim.log.levels.INFO)
end

-- Set mapleader and maplocalleader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Load plugins
require('plugins') -- install plugins

-- require('style') -- colorscheme etc.
-- Personal configurations
require('keys') -- personal keybindings
require('opts') -- options
require('autocmds') -- autocommands
require('functions') -- personal functions

-- require('language-servers') -- language server setup and settings

vim.filetype.add({
  filename = {
    ["skhdrc"] = "sh",
  }
})
