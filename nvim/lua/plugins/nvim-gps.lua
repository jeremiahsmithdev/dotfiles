-- Set to true to disable this plugin
local DISABLED = false
if DISABLED then return {} end

return {
  "SmiteshP/nvim-gps",
  dependencies = "nvim-treesitter/nvim-treesitter",
  config = function()
    local gps = require("nvim-gps")

    require("lualine").setup({
    	sections = {
    			lualine_c = {
    				{ gps.get_location, cond = gps.is_available },
    			}
    	}
    })
  end,
}