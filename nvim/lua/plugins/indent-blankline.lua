-- Set to true to disable this plugin
local DISABLED = false
if DISABLED then return {} end

return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {},
}