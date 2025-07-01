-- Set to true to disable this plugin
local DISABLED = false
if DISABLED then return {} end

return {
  "sindrets/diffview.nvim",
  dependencies = { "ellisonleao/gruvbox.nvim" },
  config = function()
    require("diffview").setup({
    })
    
  end
}
