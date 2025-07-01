--[[
  Plugin Manager and Plugins Setup for Neovim

  This configuration uses lazy.nvim as the plugin manager to handle all plugins.
  See: https://github.com/folke/lazy.nvim
  For further configuration info, see :help lazy.nvim.txt
]]--

-- [] TODOS
-- trouble.nvim?

-- Install lazy.nvim if not present
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

--[[
Plugin List and Configuration
- Individual plugins are now organized in separate files under lua/plugins/
- Each plugin file returns a plugin spec that lazy.nvim can understand
- This makes the configuration more modular and easier to maintain
]]--

-- Auto-discover and load all plugin configurations from the plugins directory
local function get_plugin_files()
  local plugins_dir = vim.fn.stdpath('config') .. '/lua/plugins'
  local plugin_files = {}
  
  -- Get all .lua files in the plugins directory
  local files = vim.fn.glob(plugins_dir .. '/*.lua', false, true)
  
  for _, file in ipairs(files) do
    -- Extract filename without path and extension
    local filename = vim.fn.fnamemodify(file, ':t:r')
    -- Skip init.lua, files with dots (like save.plugins), and hidden files
    if filename ~= 'init' and not filename:match('%.') and not filename:match('^%.') then
      table.insert(plugin_files, 'plugins.' .. filename)
    end
  end
  
  return plugin_files
end

-- Load plugin manager configuration
local plugin_manager = require('plugin-manager')

local plugins = {}
local plugin_files = get_plugin_files()

-- Create a temporary table to store plugins with their metadata
local plugin_entries = {}

for _, plugin_file in ipairs(plugin_files) do
  local ok, plugin_spec = pcall(require, plugin_file)
  if ok and type(plugin_spec) == "table" then
    -- Extract filename for matching
    local filename = plugin_file:match("plugins%.(.+)$")
    
    local function process_spec(spec)
      if type(spec) ~= "table" then
        return
      end
      
      -- Get plugin name (first element is usually the plugin name)
      local plugin_name = spec[1]
      
      -- Check if this plugin should be disabled
      if plugin_manager.is_disabled(plugin_name, filename) then
        local display_name = (type(plugin_name) == "string" and plugin_name ~= "") and plugin_name or filename
        vim.notify("Disabled plugin: " .. display_name, vim.log.levels.INFO)
        return
      end
      
      -- Get priority for ordering
      local priority = plugin_manager.get_priority(plugin_name, filename)
      
      table.insert(plugin_entries, {
        spec = spec,
        priority = priority,
        name = plugin_name,
        filename = filename
      })
    end
    
    if plugin_spec[1] then -- Single plugin spec
      process_spec(plugin_spec)
    else -- Multiple plugin specs
      for _, spec in ipairs(plugin_spec) do
        process_spec(spec)
      end
    end
  elseif not ok then
    vim.notify("Failed to load plugin: " .. plugin_file .. " - " .. plugin_spec, vim.log.levels.WARN)
  end
end

-- Sort plugins by priority
table.sort(plugin_entries, function(a, b)
  return a.priority < b.priority
end)

-- Extract the sorted specs
for _, entry in ipairs(plugin_entries) do
  table.insert(plugins, entry.spec)
end

require('lazy').setup(plugins)

-- END OF PLUGIN SETUP
