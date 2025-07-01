return {
  "robitx/gp.nvim",
  config = function()
    local config = {
      api_key = os.getenv("OPENAI_API_KEY"),
    }
    require("gp").setup(config)
  end,
}