-- Set to true to disable this plugin
local DISABLED = false
if DISABLED then return {} end

return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  opts = {
    -- Default options:
    terminal_colors = true, -- add neovim terminal colors
    undercurl = true,
    underline = true,
    bold = true,
    italic = {
      strings = true,
      emphasis = true,
      comments = true,
      operators = false,
      folds = true,
    },
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    inverse = true, -- invert background for search, diffs, statuslines and errors
    contrast = "", -- can be "hard", "soft" or empty string
    palette_overrides = {},
    overrides = {
      SignColumn = {bg = "bg"}, -- sign column same as bg
      
      -- GitHub-style diff colors for all diff views
      DiffAdd = { bg = "#1a2f1a", fg = "#acf2bd" },      -- Soft green
      DiffDelete = { bg = "#2b1a1a", fg = "#ffb3ba" },   -- Soft red  
      DiffChange = { bg = "#2b2419", fg = "#ffecb3" },   -- Soft orange
      DiffText = { bg = "#fb8500", fg = "#ffffff", bold = true }, -- Bold changed text

    },
    dim_inactive = false,
    transparent_mode = false,
  },
  config = function(_, opts)
    require("gruvbox").setup(opts)
    vim.g.colors_name = 'gruvbox'
    vim.cmd 'colo gruvbox'
  end,
}
