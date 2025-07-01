return {
  "johnseth97/codex.nvim",
  lazy = true,
  keys = {
    {
      "<leader>cc",
      function() require("codex").toggle() end,
      desc = "Toggle Codex popup",
    },
  },
  opts = {
    keymaps     = {},
    border      = "rounded",
    width       = 0.8,
    height      = 0.8,
    autoinstall = true,
  },
}