-- configure lualine --
local gps = require("nvim-gps")
require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox',
    -- component_separators = '',
    -- section_separators = { left = '', right = '' },
    -- component_separators = { left = '', right = '' },
    -- component_separators = { left = '', right = ''},
    -- section_separators = { left = '', right = ''},

    -- disabling separators
    section_separators = '', component_separators = '',

    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff',
                  {'diagnostics', sources={'nvim_lsp', 'ale'}}},
    -- lualine_c = { '%{strftime("%a %I:%M%p")}'},
    lualine_c = {
      '%{strftime("%a %I:%M%p")}' ; function()
        return require('do').view('active')
      end,
    },

    lualine_x = {
      { 'diagnostics', sources = {"nvim_lsp"}, symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '} },
      'encoding',
      'filetype'
    },
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
  lualine_a = {'buffers'},
  lualine_b = {},
  lualine_c = {},
  lualine_x = {},
  lualine_y = {},
  lualine_z = {}
},
  extensions = {}

}
