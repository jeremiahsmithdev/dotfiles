-- Telescope integration (most common way to use it)
vim.keymap.set("n", "<leader>xt", "<cmd>TodoTelescope<CR>", { desc = "Todo (Telescope)" })
vim.keymap.set("n", "<leader>xT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<CR>", { desc = "Todo/Fix/Fixme" })

-- Keybindings for dap-ui actions
vim.keymap.set('n', '<leader>du', function() require('dapui').open() end, { desc = 'DAP UI Open' })
vim.keymap.set('n', '<leader>dc', function() require('dapui').close() end, { desc = 'DAP UI Close' })
vim.keymap.set('n', '<leader>dt', function() require('dapui').toggle() end, { desc = 'DAP UI Toggle' })
-- DAP
    vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
    vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
    vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
    vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
    vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
    vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
    vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
    vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
    vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
    vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
      require('dap.ui.widgets').hover()
    end)
    vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
      require('dap.ui.widgets').preview()
    end)
    vim.keymap.set('n', '<Leader>df', function()
      local widgets = require('dap.ui.widgets')
      widgets.centered_float(widgets.frames)
    end)
    vim.keymap.set('n', '<Leader>ds', function()
      local widgets = require('dap.ui.widgets')
      widgets.centered_float(widgets.scopes)
    end)

Bind = require('binds')
Bind('n', ';', ':', 'noremap')
Bind('n', 'q', ':q', 'noremap')
Bind('n', 'Q', ':q!', 'noremap')

-- Treesitter
-- inside on_attach(client, bufnr)
-- local opts = { buffer = bufnr, desc = 'Go to definition' }
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)

-- GitSigns

-- Map <space>s to stage hunk
vim.keymap.set('n', '<space>s', function()
  require('gitsigns').stage_hunk()
end, { desc = 'Gitsigns: Stage Hunk' })

-- Map <space>S to stage entire file
vim.keymap.set('n', '<space>S', function()
  require('gitsigns').stage_buffer()
end, { desc = 'Gitsigns: Stage Buffer' })

-- Telescope
local builtin = require('telescope.builtin')
Bind('n', '<leader>rg', ':Telescope live_grep<CR>', 'noremap')
Bind('n', '<leader>lg', ':Telescope live_grep<CR>', 'noremap')
Bind('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
-- Bind('n', '<leader>rg', builtin.live_grep, { desc = 'Telescope live_grep' })
Bind('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
Bind('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- CodeCompanion
-- vim.api.nvim_create_user_command('CC', ':CodeCompanion', {})
Bind('n', '<leader>cc', ':CodeCompanion<CR>', 'noremap')
-- Bind('c', '<leader>cc', 'CodeCompanion', 'noremap')
Bind('n', '<leader>e', ':CodeCompanionEdit<CR>', 'noremap')
Bind('c', 'chat', 'CodeCompanionChat<CR>', 'noremap')
Bind('c', 'cc ', 'CodeCompanion ', 'noremap')
-- Bind('c', ':', 'CodeCompanion ', 'noremap')
Bind('n', '<leader>t', ':CodeCompanionChat Toggle<CR>', 'noremap')

vim.keymap.set('v', '<leader>cc', ':CodeCompanion<CR>', { 
  desc = 'Run CodeCompanion on selection',
  noremap = true,
  silent = true
})
-- General
Bind('n', '<leader>ai', ':r!sgpt --code ""<left>', 'noremap')
Bind('n', '<leader>n', ':NvimTreeToggle<CR>', 'noremap')


-- Bind('n', '<CR>', ':ObsidianFollowLink<CR>', 'noremap')

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
vim.api.nvim_create_user_command('Auto', 'edit ~/.config/nvim/lua/autocmds.lua', {})
vim.api.nvim_create_user_command('Plugins', 'edit ~/.config/nvim/lua/plugins.lua', {})
vim.api.nvim_create_user_command('Style', 'edit ~/.config/nvim/lua/style.lua', {})
vim.api.nvim_create_user_command('LG', 'LazyGit', {})
vim.api.nvim_create_user_command('Diff', function()
  local file = vim.fn.expand('%:t')
  local ext = vim.fn.expand('%:e')
  local fname = 'diff'
  if ext ~= '' then
    fname = fname .. '.' .. ext
  end
  vim.cmd('vert new ' .. fname .. ' | read # | 1delete')
  vim.api.nvim_win_set_option(0, 'winbar', '│ SAVED FILE')
  vim.bo.buflisted = false -- Hide from buffer list
  vim.cmd('diffthis | wincmd p | diffthis')
end, {})





-- Directories
vim.api.nvim_create_user_command('Config', 'edit ~/.config/nvim', {})
vim.api.nvim_create_user_command('Dotfiles', 'edit ~/dotfiles', {})

-- plahing around
require('functions')
-- create_command('hii', 'echo "Hi"')

--Lazy Lazy 
vim.cmd("cabbrev lg LazyGit")

-- source current file
vim.cmd("cabbrev <expr> sof getcmdtype() == ':' ? 'source %' : 'sof'")
vim.cmd("cabbrev <expr> sf getcmdtype() == ':' ? 'source %' : 'sf'")

-- expand firenvim
vim.cmd("cabbrev Expand set lines=10 | set columns=100")
vim.cmd("cabbrev Ex set lines=10 | set columns=100")
vim.cmd("cabbrev EXPAND set lines=20 | set columns=200")
vim.cmd("cabbrev EX set lines=20 | set columns=200")

-- local file = vim.api.nvim_buf_get_name(0)
-- local file = vim.api.nvim_get_current_buf(0)
-- local file = expand('%')
vim.api.nvim_create_user_command('Open', function()
  local file = vim.api.nvim_buf_get_name(0)
  os.execute('open "' .. file .. '" &')
end, {})

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

vim.cmd([[command! -nargs=0 Gp n ~/.config/nvim/lua/config/gp.lua]]) -- open gp.lua keymaps file
vim.api.nvim_set_keymap('n', '<leader>gp', ':n ~/.config/nvim/lua/config/gp.lua<CR>', { noremap = true, silent = true }) -- open gp.lua keymaps file

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

-- Define the function
local function close_special_buffers()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    local name = vim.api.nvim_buf_get_name(buf)

    -- Handle both normal paths and special buffer names like [CodeCompanion]
    local fname = name
    if name ~= "" then
      fname = vim.fn.fnamemodify(name, ":t")  -- get the filename from full path
    end

    local matches = {
      "^diff.*",
      "^%[CodeCompanion%].*",
      "DiffviewFilePanel",
      "DAP.*",
    }
    for _, pat in ipairs(matches) do
      if fname:match(pat) then
        vim.cmd("bd! " .. buf)
        return
      end
    end
  end

  -- Fallback: try to quit window
  local ok, err = pcall(function()
    vim.api.nvim_feedkeys(':q', 'n', false)
  end)

  if not ok then
    vim.notify("Unsaved changes — use :q! to force quit", vim.log.levels.WARN)
  end
end

-- end

-- Create :Close command
vim.api.nvim_create_user_command("Close", close_special_buffers, {
  desc = "Close diff or CodeCompanion buffer, else try to quit",
})

-- Map `q` to the same logic
vim.keymap.set("n", "q", close_special_buffers, {
  desc = "Close diff/CodeCompanion buffer or fallback to quit",
})

-- Create :Close command
vim.api.nvim_create_user_command("Close", close_special_buffers, {})

-- Map `q` to that same fn
vim.keymap.set("n", "q", close_special_buffers)


--   -- Fallback: try to quit window
--   local ok, err = pcall(function()
--     vim.api.nvim_feedkeys(':q', 'n', false)
--   end)
--
--   if not ok then
--     vim.notify("Unsaved changes — use :q! to force quit", vim.log.levels.WARN)
--   end
-- end, { desc = "Close diff or CodeCompanion buffer, else quit" })

-- Show vertical Git diff vs HEAD
vim.api.nvim_create_user_command('Gdiff', function()
  local abs_path = vim.api.nvim_buf_get_name(0)
  if abs_path == '' then
    vim.notify("No file loaded in buffer", vim.log.levels.ERROR)
    return
  end

  -- Get Git root
  local git_root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
  if not git_root or git_root == '' then
    vim.notify("Not inside a Git repository", vim.log.levels.ERROR)
    return
  end

  -- Get path relative to Git root
  -- local rel_path = vim.fn.fnamemodify(abs_path, ':.' .. git_root)
  local rel_path = abs_path:sub(#git_root + 2)

  -- Get file contents at HEAD using Lua
  local handle = io.popen('git show HEAD:' .. rel_path)
  if not handle then
    vim.notify("Failed to run git show", vim.log.levels.ERROR)
    return
  end

  local content = handle:read("*a")
  handle:close()

  if not content or content == '' then
    vim.notify("Empty or invalid file content from HEAD", vim.log.levels.WARN)
    return
  end

  local file = vim.fn.expand('%:t')
  local ext = vim.fn.expand('%:e')
  local fname = 'diff'
  if ext ~= '' then
    fname = fname .. '.' .. ext
  end

  -- Open vertical split and load diff buffer
  vim.cmd('vnew ' .. fname)

  -- Split the content cleanly and insert it
  local lines = vim.split(content, '\n', { plain = true })
  if lines[#lines] == '' then table.remove(lines) end  -- remove trailing empty line
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)

  -- Set winbar for visual alignment (optional)
  vim.api.nvim_win_set_option(0, 'winbar', '│ GIT HEAD')
  vim.bo.buflisted = false -- Hide from buffer list


  -- Enable diff mode
  vim.cmd('diffthis')

  -- Go back and diff original
  vim.cmd('wincmd p')
  vim.cmd('diffthis')
end, { desc = 'Clean side-by-side diff with HEAD using Lua + Git' })

-- vim.api.nvim_set_keymap('n', '<C-n>', ':Close<CR> | :bn<CR> | :Gdiff<CR>', { noremap = false, silent = true })

local function smart_ctrl_n()
  -- Check if we are in diff mode
  if vim.wo.diff then
    vim.cmd([[
    Close
    bnext
    Gdiff
]])
  else
    vim.cmd('bnext')
  end
end

local function smart_ctrl_p()
  -- Check if we are in diff mode
  if vim.wo.diff then
    vim.cmd([[
    Close
    bprev
    Gdiff
]])
  else
    vim.cmd('bprev')
  end
end

vim.keymap.set('n', '<C-n>', smart_ctrl_n, { noremap = false, silent = true })

vim.api.nvim_create_user_command('Reload', function()
  -- Get list of loaded buffers with file paths
  local buffers = {}
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_option(buf, 'buflisted') then
      local name = vim.api.nvim_buf_get_name(buf)
      if name ~= '' and vim.fn.filereadable(name) == 1 then
        table.insert(buffers, name)
      end
    end
  end
  
  -- Save all buffers first
  vim.cmd('silent! wa')
  
  -- Get current Neovim process PID
  local current_pid = vim.fn.getpid()
  
  -- Create unique buffer file using PID to avoid conflicts
  local buffer_file = '/tmp/nvim_buffers_' .. current_pid
  local file = io.open(buffer_file, 'w')
  if file then
    for _, buffer_path in ipairs(buffers) do
      file:write(buffer_path .. '\n')
    end
    file:close()
    
    -- Try using vim's job control for better process management
    local nvim_args = {}
    for _, buffer_path in ipairs(buffers) do
      table.insert(nvim_args, buffer_path)
    end
    
    -- Use vim.fn.jobstart with proper terminal attachment
    local job_id = vim.fn.jobstart({'nvim', unpack(nvim_args)}, {
      detach = true,
      stdin = 'null',
      stdout = 'inherit',
      stderr = 'inherit',
    })
    
    if job_id > 0 then
      -- Job started successfully, now exit
      vim.defer_fn(function()
        vim.cmd('qa!')
      end, 100)
    else
      vim.notify('Failed to start reload job', vim.log.levels.ERROR)
    end
  else
    vim.notify('Failed to create buffer file for reload', vim.log.levels.ERROR)
  end
end, { desc = 'Exit and reopen Neovim with same buffers using external script' })


