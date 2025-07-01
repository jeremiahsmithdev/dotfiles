-- Set to true to disable this plugin
local DISABLED = false
if DISABLED then return {} end

return {
  "rcarriga/nvim-dap-ui",
  dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
  config = function()
    require("dapui").setup()
  end
}