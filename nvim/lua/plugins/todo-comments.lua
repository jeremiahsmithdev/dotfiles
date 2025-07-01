return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    keywords = {
      FIX = {
        icon = " ",
        color = "#FF2222",
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
      },
      TODO = { icon = " ", color = "#2AA9F9" },
      HACK = { icon = " ", color = "#FF8800" },
      WARN = { icon = " ", color = "#FFFF00", alt = { "WARNING", "XXX" } },
      PERF = { icon = " ", color = "#7C3AED", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = " ", color = "#00FFAA", alt = { "INFO" } },
      TEST = { icon = "⏲ ", color = "#5EEA37", alt = { "TESTING", "PASSED", "FAILED" } },
    },
  }
}