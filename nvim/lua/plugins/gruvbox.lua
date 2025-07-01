-- Set to true to disable this plugin
local DISABLED = false
if DISABLED then return {} end

return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  config = true,
  opts = {}
}