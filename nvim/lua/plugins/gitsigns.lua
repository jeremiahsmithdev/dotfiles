return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("config.gitsigns")
  end,
  dependencies = { "nvim-lua/plenary.nvim" },
}