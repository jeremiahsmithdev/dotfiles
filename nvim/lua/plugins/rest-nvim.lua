-- Set to true to disable this plugin
local DISABLED = false
if DISABLED then return {} end

return {
  "rest-nvim/rest.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  ft = "http",
  config = function()
    require("rest-nvim").setup({})
  end,
}