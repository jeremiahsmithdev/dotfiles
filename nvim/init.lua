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

-- Language server configurations
require('language-servers') -- language server setup and settings

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

-- navigation
vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)
-- resizing
vim.keymap.set('n', '<A-h>', require('smart-splits').resize_left)
vim.keymap.set('n', '<A-j>', require('smart-splits').resize_down)
vim.keymap.set('n', '<A-k>', require('smart-splits').resize_up)
vim.keymap.set('n', '<A-l>', require('smart-splits').resize_right)
-- swapping
vim.keymap.set('n', '<A-H>', require('smart-splits').swap_buf_left)
vim.keymap.set('n', '<A-J>', require('smart-splits').swap_buf_down)
vim.keymap.set('n', '<A-K>', require('smart-splits').swap_buf_up)
vim.keymap.set('n', '<A-L>', require('smart-splits').swap_buf_right)

-- lsp symbols
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN]  = "",
      [vim.diagnostic.severity.HINT]  = "",
      [vim.diagnostic.severity.INFO]  = "",
    },
  },
})

vim.filetype.add({
  filename = {
    ["skhdrc"] = "sh",
  }
})


