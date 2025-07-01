-- Set to true to disable this plugin
local DISABLED = false
if DISABLED then return {} end

return {
  "xiyaowong/transparent.nvim",
  config = function()
    require('transparent').setup()
  end,
}