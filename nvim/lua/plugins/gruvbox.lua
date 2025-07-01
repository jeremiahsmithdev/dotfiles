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
  -- Make sign column background match normal background

  -- GitHub-style diff colors matching screenshot
  -- DiffAdd    = { bg = "#5a6e3a" },           -- olive green
  -- DiffDelete = { bg = "#7c3636", fg = "#fb4934" }, -- muted red
  -- DiffChange = { bg = "#504945" },           -- neutral gray (gruvbox palette)
  -- DiffText   = { bg = "#7c3636", fg = "#fb4934", bold = true }, -- red on red, bold
  --
  -- -- Gitsigns colors to match
  -- GitSignsAdd    = { fg = "#b8bb26" },
  -- GitSignsDelete = { fg = "#fb4934" },
  -- GitSignsChange = { fg = "#fabd2f" },
},

    dim_inactive = false,
    transparent_mode = false,
  },
  config = function(_, opts)
    require("gruvbox").setup(opts)
    vim.cmd.colorscheme('gruvbox')
  end,
}
