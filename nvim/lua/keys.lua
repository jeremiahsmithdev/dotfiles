Bind = require('binds')
Bind('n', ';', ':', 'noremap')
Bind('v', ';', ':', 'noremap')
Bind('n', 'Q', ':q!', 'noremap')

Bind('n', '<leader>ai', ':r!sgpt --code ""<left>', 'noremap')
Bind('n', '<leader>n', ':NvimTreeToggle<CR>', 'noremap')


Bind('n', '<CR>', ':ObsidianFollowLink<CR>', 'noremap')

-- firenvim
Bind('n' , '<C-e>', ':q', 'noremap')

-- Leap
Bind('n', 'f', '<Plug>(leap-forward)')
Bind('n', 'F', '<Plug>(leap-backward)')
Bind('v', 'f', '<Plug>(leap-forward)')
Bind('v', 'F', '<Plug>(leap-backward)')

-- buffer navigation
Bind('n', '<C-n>', ':bn<CR>', 'noremap')-- nmap <C-n> :bn<CR> " Next buffer
Bind('n', '<C-p>', ':bp<CR>', 'noremap')-- nmap <C-p> :bp<CR> " previous buffer
Bind('n', '<C-#>', ':b#<CR>', 'noremap')-- nmap <C-#> :b#<CR> " previous buffer you were in
Bind('n', '<C-3>', ':b#<CR>', 'noremap')-- nmap <C-3> :b#<CR> " ditto

-- accept autopilot mapping 
-- Bind('i', '<C-e>', 'copilot#Accept("<CR>"', 'noremap')

-- get the path of the current file
vim.cmd("cabbrev <expr> path getcmdtype() == ':' ? 'echo expand(\"%:p\")' : 'path<CR>'")
vim.api.nvim_create_user_command('Path', 'echo expand("%:p")', {})

-- source vim
vim.api.nvim_create_user_command('So', 'source ~/.config/nvim/init.lua', {})
vim.api.nvim_create_user_command('Fill', 'set lines=50 | set columns=200', {})
vim.api.nvim_create_user_command('Tall', 'set lines=50', {})

-- Opening config files
vim.api.nvim_create_user_command('Init', 'edit ~/.config/nvim/init.lua', {})
vim.api.nvim_create_user_command('Plugs', 'edit ~/.config/nvim/lua/plugins.lua', {})
vim.api.nvim_create_user_command('Keys', 'edit ~/.config/nvim/lua/keys.lua', {})
vim.api.nvim_create_user_command('Opts', 'edit ~/.config/nvim/lua/opts.lua', {})
vim.api.nvim_create_user_command('Autocmnds', 'edit ~/.config/nvim/lua/autocmds.lua', {})
vim.api.nvim_create_user_command('Plugins', 'edit ~/.config/nvim/lua/plugins.lua', {})
vim.api.nvim_create_user_command('Style', 'edit ~/.config/nvim/lua/style.lua', {})

-- plahing around
require('functions')
-- create_command('hii', 'echo "Hi"')


-- source current file
vim.cmd("cabbrev <expr> sof getcmdtype() == ':' ? 'source %' : 'sof'")
vim.cmd("cabbrev <expr> sf getcmdtype() == ':' ? 'source %' : 'sf'")

-- expand firenvim
vim.cmd("cabbrev Expand set lines=10 | set columns=100")
vim.cmd("cabbrev Ex set lines=10 | set columns=100")
vim.cmd("cabbrev EXPAND set lines=20 | set columns=200")
vim.cmd("cabbrev EX set lines=20 | set columns=200")

-- MarkdownPreview
vim.cmd("cabbrev preview MarkdownPreview")

-- Obsidian
vim.cmd("cabbrev today ObsidianToday")
vim.cmd("cabbrev week ObsidianWeek") -- create template for week
-- should automatically link to all daily entries
vim.cmd("cabbrev month ObsidianMonth") -- create template for month
vim.cmd("cabbrev year ObsidianYear") -- create template for year
vim.cmd("cabbrev all ObsidianAll") -- create template for all time

-- vim.api.nvim_set_keymap('i', '<C-e>', '<esc>:lua acceptCodeiumSuggestion()<CR>', {noremap = true, silent = true})

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.cmd([[command! -nargs=0 Gp n ~/.config/nvim/lua/plugs/gp.lua]]) -- open gp.lua keymaps file
vim.api.nvim_set_keymap('n', '<leader>gp', ':n ~/.config/nvim/lua/plugs/gp.lua<CR>', { noremap = true, silent = true }) -- open gp.lua keymaps file

-- rest.nvim
Bind('n', '<leader>rn', '<Plug>RestNvim')
Bind('n', '<leader>rp', '<Plug>RestNvimPreview')
Bind('n', '<leader>rl', '<Plug>RestNvimLast')
Bind('n', '<leader>rd', '<Plug>RestNvimDebug') -- real?
Bind('n', '<leader>rdl', '<Plug>RestNvimDebugLast') -- real?

-- -- indent and outdent lines quickly
-- vim.keymap.set('n', '<TAB>', '>>')
-- vim.keymap.set('n', '<S-TAB>', '<<')

-- indent and outdent lines in visual mode
vim.keymap.set('v', '<TAB>', '<S->>gv')
vim.keymap.set('v', '<S-TAB>', '<S-<>gv')

-- select the entire file with control + A
vim.keymap.set('n', '<C-a>', 'ggVG')

-- the greatest remap ever (Primeagen)
vim.keymap.set('v', '<leader>p', '"_dP')

-- the greatest remap ever (Primeagen)
vim.keymap.set('v', '<leader>p', '"_dP') -- not working?

-- lspsaga
vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>')

-- cheatsheet
vim.keymap.set('n', '<leader>c', ':Cheatsheet<CR>')

--- In lsp attach function
-- local map = vim.api.nvim_buf_set_keymap
-- map(0, "n", "gr", "<cmd>Lspsaga rename<cr>", {silent = true, noremap = true})
-- map(0, "n", "gx", "<cmd>Lspsaga code_action<cr>", {silent = true, noremap = true})
-- map(0, "x", "gx", ":<c-u>Lspsaga range_code_action<cr>", {silent = true, noremap = true})
-- map(0, "n", "K",  "<cmd>Lspsaga hover_doc<cr>", {silent = true, noremap = true})
-- map(0, "n", "go", "<cmd>Lspsaga show_line_diagnostics<cr>", {silent = true, noremap = true})
-- map(0, "n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", {silent = true, noremap = true})
-- map(0, "n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", {silent = true, noremap = true})
-- map(0, "n", "<C-u>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1, '<c-u>')<cr>", {})
-- map(0, "n", "<C-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1, '<c-d>')<cr>", {})
