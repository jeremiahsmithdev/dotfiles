-- Set to true to disable this plugin
local DISABLED = false
if DISABLED then return {} end

return {
  "brianhuster/live-preview.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "ibhagwan/fzf-lua",
    "echasnovski/mini.pick",
  },
}