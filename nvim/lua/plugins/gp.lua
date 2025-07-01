-- Set to true to disable this plugin
local DISABLED = false
if DISABLED then return {} end

return {
  "robitx/gp.nvim",
  config = function()
    local config = {
      api_key = os.getenv("OPENAI_API_KEY"),
    }
    require("gp").setup(config)
  end,
}