-- Set to true to disable this plugin
local DISABLED = false
if DISABLED then return {} end

return {
  "Exafunction/codeium.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
  },
  config = function()
    -- require('codeium').setup{
    --   -- default keymap options
    --
    -- }
  end,
}