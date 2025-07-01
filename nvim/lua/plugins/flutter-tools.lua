-- Set to true to disable this plugin
local DISABLED = false
if DISABLED then return {} end

return {
  "nvim-flutter/flutter-tools.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim",
  },
  config = true,
}