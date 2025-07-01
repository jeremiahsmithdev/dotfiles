--[[
  Plugin Manager Configuration
  
  This file allows you to control:
  1. Which plugins are disabled
  2. The order in which plugins are loaded
  
  Plugins not mentioned here will still load normally after the ordered ones.
  
  Usage:
  - Add plugin names or filenames to M.disabled_plugins to disable them
  - Add plugin names or filenames to M.load_order to control loading order
  - Use :PluginManagerList to see current load order
  - Use :PluginManagerDebug to toggle debug messages
  
  Example:
    M.disabled_plugins = { "codeium", "copilot.nvim" }
    M.load_order = { "plenary.nvim", "telescope", "nvim-treesitter" }
]]--

local M = {}

-- List plugins to disable (by plugin name or file name)
M.disabled_plugins = {
  -- DISABLING ALL PLUGINS EXCEPT CORE ESSENTIALS
  -- Keep only: treesitter, telescope, lsp, nvim-cmp, plenary, gruvbox
  
  -- UI/Visual plugins
  -- "todo-comments",
  -- "noice",
  -- "lspsaga",
  -- "indent-blankline",
  -- "vim-illuminate",
  -- "nvim-treesitter-context",
  -- "nvim-gps",
  -- "nvim-notify",
  -- "dressing.nvim",
  -- "alpha",
  -- "lualine",
  -- "bufferline",
  -- "nvim-web-devicons",
  
  -- AI/Completion plugins
  -- "codecompanion",
  -- "codeium",
  -- "copilot",
  -- "avante",
  -- "gp",
  
  -- Git plugins
  -- "git",
  -- "gitsigns",
  -- "diffview",
  -- "neogit",
  -- "vim-fugitive",
  -- "vim-rhubarb",
  
  -- File explorers
  -- "nvim-tree",
  -- "neo-tree",
  -- "oil",
  
  -- Utility plugins
  -- "which-key",
  -- "trouble",
  -- "flash",
  -- "leap",
  -- "vim-sleuth",
  -- "Comment",
  -- "vim-surround",
  -- "nvim-autopairs",
  -- "markdown-preview",
  -- "rest-nvim",
  -- "remote-nvim",
  -- "obsidian",
  -- "zen-mode",
  -- "twilight",
  -- "neoscroll",
  -- "smart-splits",
  "vim-tmux-navigator",
  
  -- DAP/Debug plugins
  -- "dap",
  -- "dap-ui",
  -- "dap-virtual-text",
  
  -- Other plugins
  -- "lspkind",
  -- "fidget",
  -- "neodev",
  -- "mason",
  -- "mason-lspconfig",
  -- "luasnip",
  -- "friendly-snippets",
  
  -- Any file-based names
  -- "diff",
  -- "mcphub",
  -- "formatting",
  -- "refactoring",
  -- "harpoon",
  -- "undotree",
}

-- Enable debug messages to see loading order
M.debug = false

-- Define explicit loading order for plugins that need it
-- Use either the plugin name (e.g., "nvim-treesitter") or the filename without .lua (e.g., "treesitter")
M.load_order = {
  -- Core dependencies first
  "plenary.nvim",
  "nvim-web-devicons",
  
  -- UI and theme
  "gruvbox",
  "alpha",
  
  -- Core functionality
  "telescope",
  "nvim-treesitter",  -- Match exact plugin name
  "treesitter",        -- Also match filename
  "nvim-lspconfig",    -- Match exact plugin name
  "lsp",               -- Also match filename
  "nvim-cmp",
  
  -- Git
  "git",
  "diffview",
  
  -- Everything else loads in discovery order
}

-- Debug logging function
function M.log(msg)
  if M.debug then
    vim.notify("[Plugin Manager] " .. msg, vim.log.levels.INFO)
  end
end

-- Function to check if a plugin should be disabled
function M.is_disabled(plugin_name, filename)
  -- Ensure plugin_name is a string
  if type(plugin_name) ~= "string" then
    plugin_name = nil
  end
  
  for _, disabled in ipairs(M.disabled_plugins) do
    -- Exact match or pattern match
    if plugin_name and (plugin_name == disabled or plugin_name:match(disabled)) then
      return true
    end
    if filename and (filename == disabled or filename:match(disabled)) then
      return true
    end
  end
  return false
end

-- Function to get plugin priority (lower number = higher priority)
function M.get_priority(plugin_name, filename)
  -- Ensure plugin_name is a string
  if type(plugin_name) ~= "string" then
    plugin_name = nil
  end
  
  for i, ordered in ipairs(M.load_order) do
    -- Exact match or pattern match
    if plugin_name and (plugin_name == ordered or plugin_name:match(ordered)) then
      M.log(string.format("Priority %d for plugin: %s", i, plugin_name))
      return i
    end
    if filename and (filename == ordered or filename:match(ordered)) then
      M.log(string.format("Priority %d for file: %s", i, filename))
      return i
    end
  end
  return 999 -- Default priority for unordered plugins
end

-- Command to toggle debug mode and show current plugin order
vim.api.nvim_create_user_command('PluginManagerDebug', function()
  M.debug = not M.debug
  vim.notify("[Plugin Manager] Debug mode: " .. (M.debug and "ON" or "OFF"), vim.log.levels.INFO)
end, { desc = "Toggle plugin manager debug mode" })

-- Command to list current plugin load order
vim.api.nvim_create_user_command('PluginManagerList', function()
  local plugins_dir = vim.fn.stdpath('config') .. '/lua/plugins'
  local files = vim.fn.glob(plugins_dir .. '/*.lua', false, true)
  local entries = {}
  
  for _, file in ipairs(files) do
    local filename = vim.fn.fnamemodify(file, ':t:r')
    if filename ~= 'init' and not filename:match('%.') and not filename:match('^%.') then
      local plugin_file = 'plugins.' .. filename
      local ok, plugin_spec = pcall(require, plugin_file)
      
      if ok and type(plugin_spec) == "table" then
        local function add_entry(spec)
          if type(spec) == "table" and spec[1] then
            local plugin_name = spec[1]
            local priority = M.get_priority(plugin_name, filename)
            local disabled = M.is_disabled(plugin_name, filename)
            
            table.insert(entries, {
              name = plugin_name,
              filename = filename,
              priority = priority,
              disabled = disabled
            })
          end
        end
        
        if plugin_spec[1] and type(plugin_spec[1]) == "string" then
          add_entry(plugin_spec)
        else
          for _, spec in ipairs(plugin_spec) do
            add_entry(spec)
          end
        end
      end
    end
  end
  
  -- Sort by priority
  table.sort(entries, function(a, b)
    return a.priority < b.priority
  end)
  
  -- Display results
  vim.notify("=== Plugin Load Order ===", vim.log.levels.INFO)
  for i, entry in ipairs(entries) do
    local status = entry.disabled and " [DISABLED]" or ""
    local msg = string.format("%3d. %-30s (file: %s)%s", 
      entry.priority, 
      entry.name, 
      entry.filename,
      status)
    vim.notify(msg, vim.log.levels.INFO)
  end
end, { desc = "List plugin load order" })

return M
