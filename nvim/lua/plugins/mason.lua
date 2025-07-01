-- Set to true to disable this plugin
local DISABLED = false
if DISABLED then return {} end

return {
  "mason-org/mason-lspconfig.nvim",
  ensure_installed = {"intelephense"},
  opts = {},
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
    { "j-hui/fidget.nvim", opts = {} },
    "folke/neodev.nvim",
  },
  config = function()
    require('mason').setup()
    require('mason-lspconfig').setup()
  end,
}