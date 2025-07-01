-- Set to true to disable this plugin
local DISABLED = false
if DISABLED then return {} end

return {
  "nvim-tree/nvim-tree.lua",
  config = function()
    require("nvim-tree").setup()
  end,
}