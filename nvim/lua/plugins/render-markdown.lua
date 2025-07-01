-- Set to true to disable this plugin
local DISABLED = false
if DISABLED then return {} end

return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown", "codecompanion" },
}