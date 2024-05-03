-- # TODO
-- [] migrate keymaps from old config
-- [] migrate anything else
local hour = os.date("*t").hour
if hour >= 22 then
  vim.notify("It is after 10 PM", vim.log.levels.INFO)
end

-- Set mapleader and maplocalleader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Load plugins
require('plugins') -- install plugins

-- Personal configurations
require('keys') -- personal keybindings
require('style') -- colorscheme etc.
require('opts') -- options
require('autocmds') -- autocommands
require('functions') -- personal functions

-- Plugin configurations
require('plugs.lspkind')
require('plugs.telescope') -- search and navigation tool for Neovim
require('plugs.treesitter') -- language parsing for syntax highlighting, code analysis, and more
require('plugs.cmp') -- fast and powerful completion engine -> before codeium setup
require('plugs.codeium')
require('plugs.lualine') -- statusline and bufferline integrated with Lua
require('plugs.which-key') -- visualizes keybindings and available commands
require('plugs.lsp') -- support for Language Server Protocol in Neovim
require('plugs.gp') -- ChatGPT code assistant -> keymaps
require('plugs.gps')
require('plugs.obsidian')
require('plugs.do')
-- require('plugs.rest')
require('plugs.noice')
require("plugs.firenvim")
-- require('plugs.*')
-- require('plugs.lspsaga') -- untested

require("nvim-tree").setup()

-- Mason-lspconfig setup
require('mason').setup() -- lsp server package manager
require('mason-lspconfig').setup()

-- Language server configurations
require('language-servers') -- language server setup and settings
require('transparent').setup()
require('notify').setup()

require("notify").setup({
background_colour = "#1a1b26",
})

-- TODO -> plugins to add
-- [] harpoon
-- [] notify
-- [x] alpha.nvim
-- [x] Do
--
-- TODO -> cleanup
-- Plugins file clean & reformat
--
-- [ ] Check codeium vs copilot...
-- [ ] codeium tutorial -> https://codeium.com/vim_tutorial
-- [ ] create obsidian templates, see keys file
--
