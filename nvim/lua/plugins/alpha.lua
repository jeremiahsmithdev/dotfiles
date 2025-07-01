-- Set to true to disable this plugin
local DISABLED = false
if DISABLED then return {} end

return {
  "goolord/alpha-nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("alpha").setup(require("alpha.themes.startify").config)
  end,
}