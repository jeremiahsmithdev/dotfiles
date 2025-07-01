-- Set to true to disable this plugin
local DISABLED = false
if DISABLED then return {} end

return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
    { "j-hui/fidget.nvim", opts = {} },
    "folke/neodev.nvim",
  },
  config = function()
    require('mason').setup()
    require('mason-lspconfig').setup({
      -- Add any language servers you want to ensure are installed
      ensure_installed = { "lua_ls", "intelephense" },
      -- Automatically install LSPs to stdpath for neovim
      automatic_installation = true,
    })
  end,
}