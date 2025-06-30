
-- Editor options and settings

-- Essential settings
vim.opt.clipboard = 'unnamedplus'  -- System clipboard integration
vim.opt.swapfile = false           -- Disable swap files
vim.opt.backup = false             -- Disable backup files
vim.opt.undofile = true            -- Persistent undo history

-- UI settings
vim.opt.number = true              -- Show line numbers
vim.opt.relativenumber = true      -- Show relative line numbers
vim.opt.cursorline = true          -- Highlight current line
vim.opt.cursorlineopt = "number"   -- Only highlight line number
vim.opt.signcolumn = 'yes'         -- Always show sign column
vim.opt.termguicolors = true       -- Enable 24-bit RGB colors

-- Search settings
vim.opt.hlsearch = false           -- Don't highlight search results
vim.opt.ignorecase = true          -- Case-insensitive search
vim.opt.smartcase = true           -- Case-sensitive if uppercase present

-- Indentation
vim.opt.breakindent = true         -- Wrap lines with proper indentation

-- Timing
vim.opt.updatetime = 250           -- Faster completion
vim.opt.timeoutlen = 300           -- Faster key sequence timeout

-- Completion
vim.opt.completeopt = 'menuone,noselect'  -- Better completion experience

-- Mouse support
vim.opt.mouse = 'a'                -- Enable mouse in all modes

-- Obsidian UI requirement
vim.opt.conceallevel = 2

-- Remember cursor position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})
