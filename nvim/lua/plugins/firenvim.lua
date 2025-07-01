-- Set to true to disable this plugin
local DISABLED = false
if DISABLED then return {} end

return {
  "glacambre/firenvim",

  config = function()
    vim.g.firenvim_config = {
        globalSettings = { alt = "all" },
        localSettings = {
            [".*"] = {
                filename = 'Firenvim',
                -- filename = '/tmp/{hostname}_{pathname%10}.{extension}',
                cmdline  = "neovim",
                content  = "text",
                priority = 0,
                selector = "textarea",
                takeover = "never"
            }
        }
    }

    if vim.g.started_by_firenvim == true then
        require'lualine'.setup {
      options = {
        icons_enabled = true,
        theme = 'gruvbox',
        component_separators = '',
        section_separators = { left = '', right = '' },
        disabled_filetypes = {},
        always_divide_middle = true,
      },
      sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff',
                      {'diagnostics', sources={'nvim_lsp', 'ale'}}},
        lualine_c = { '%{strftime("%a %I:%M%p")}'},
        lualine_x = {
          { 'diagnostics', sources = {"nvim_lsp"}, symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '} }
          -- 'filetype'
        },
        lualine_y = {'progress'},
        lualine_z = {'location'}
      },
      inactive_sections = {
        lualine_c = {'filename'},
        lualine_x = {'location'},
      },
      tabline = {
      lualine_a = {'buffers'},
    },
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
  end,
}
