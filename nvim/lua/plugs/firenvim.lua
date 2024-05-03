vim.g.firenvim_config = {
    globalSettings = { alt = "all" },
    localSettings = {
        [".*"] = {
            cmdline  = "neovim",
            content  = "text",
            priority = 0,
            selector = "textarea",
            takeover = "never"
        }
    }
}

if vim.g.started_by_firenvim == true then
    -- remove lualine dividers in firenvim 
    -- require('lualine').setup {
    --   options = {
    --     section_separators = '',
    --     component_separators = ''
    --   }
    -- }
    --
    require'lualine'.setup {
  options = {
    icons_enabled = true,
    theme = 'gruvbox',
    component_separators = '',
    section_separators = { left = '', right = '' },
    -- component_separators = { left = '', right = ''},
    -- section_separators = { left = '', right = ''},
    -- component_separators = { left = '', right = ''},
    -- section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff',
                  {'diagnostics', sources={'nvim_lsp', 'ale'}}},
    -- lualine_c = { '%{strftime("%a %I:%M%p")}'},
    lualine_c = {
      -- 'filename',
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
    lualine_c = {'filename'},
    lualine_x = {'location'},
  },
  tabline = {
  lualine_a = {'Firenvim'},
  lualine_z = {''}
},
  extensions = {}

}

end

vim.api.nvim_create_autocmd({'UIEnter'}, {
    callback = function(event)
        local client = vim.api.nvim_get_chan_info(vim.v.event.chan).client
        if client ~= nil and client.name == "Firenvim" then
            -- vim.o.laststatus = 0
            if vim.api.nvim_win_get_height(0) == 2 then
                vim.cmd("set lines=10")
            end
        end
    end
})
