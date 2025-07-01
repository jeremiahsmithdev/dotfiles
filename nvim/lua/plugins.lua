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

local plugins = {}
local plugin_files = get_plugin_files()

for _, plugin_file in ipairs(plugin_files) do
  local ok, plugin_spec = pcall(require, plugin_file)
  if ok and type(plugin_spec) == "table" then
    if plugin_spec[1] then -- Single plugin spec
      table.insert(plugins, plugin_spec)
    else -- Multiple plugin specs
      for _, spec in ipairs(plugin_spec) do
        table.insert(plugins, spec)
      end
    end
  elseif not ok then
    vim.notify("Failed to load plugin: " .. plugin_file .. " - " .. plugin_spec, vim.log.levels.WARN)
  end
end

require('lazy').setup(plugins)

-- END OF PLUGIN SETUP
