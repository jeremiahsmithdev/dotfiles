return {
  "rcarriga/nvim-notify",
  config = function()
    require('notify').setup()
    require("notify").setup({
      background_colour = "#1a1b26",
    })
  end,
}