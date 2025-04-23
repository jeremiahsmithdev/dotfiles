-- [[ Install `lazy.nvim` plugin manager ]]
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- TODO: setup lspsaga with keymaps etc.

-- [[ Configure plugins ]]
-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration
{
    'brianhuster/live-preview.nvim',
    dependencies = {
        -- You can choose one of the following pickers
        'nvim-telescope/telescope.nvim',
        'ibhagwan/fzf-lua',
        'echasnovski/mini.pick',
    },
},
-- {
--   "folke/trouble.nvim",
--   opts = {}, -- for default options, refer to the configuration section for custom setup.
--   cmd = "Trouble",
--   keys = {
--     {
--       "<leader>xx",
--       "<cmd>Trouble diagnostics toggle<cr>",
--       desc = "Diagnostics (Trouble)",
--     },
--     {
--       "<leader>xX",
--       "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
--       desc = "Buffer Diagnostics (Trouble)",
--     },
--     {
--       "<leader>cs",
--       "<cmd>Trouble symbols toggle focus=false<cr>",
--       desc = "Symbols (Trouble)",
--     },
--     {
--       "<leader>cl",
--       "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
--       desc = "LSP Definitions / references / ... (Trouble)",
--     },
--     {
--       "<leader>xL",
--       "<cmd>Trouble loclist toggle<cr>",
--       desc = "Location List (Trouble)",
--     },
--     {
--       "<leader>xQ",
--       "<cmd>Trouble qflist toggle<cr>",
--       desc = "Quickfix List (Trouble)",
--     },
--   },
-- },
{
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
},
  {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- Set this to "*" to always pull the latest release version, or set it to false to update to the latest code changes.
  opts = {
    -- add any opts here
    -- for example
    provider = "openai",
    openai = {
      endpoint = "https://api.openai.com/v1",
      model = "gpt-4o", -- your desired model (or use gpt-4o, etc.)
      timeout = 30000, -- timeout in milliseconds
      temperature = 0, -- adjust if needed
      max_tokens = 4096,
      -- reasoning_effort = "high" -- only supported for reasoning models (o1, etc.)
    },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "echasnovski/mini.pick", -- for file_selector provider mini.pick
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "ibhagwan/fzf-lua", -- for file_selector provider fzf
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
},

  -- new plugins
  -- lspsaga -- issue -> makes autosuggestion list blue text
'nvim-lua/plenary.nvim',
'kdheepak/lazygit.nvim',
{
    'nvim-flutter/flutter-tools.nvim',
    lazy = false,
    dependencies = {
        'nvim-lua/plenary.nvim',
        'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = true,
},
'famiu/nvim-reload',
  {
    'nvimdev/lspsaga.nvim',
    config = function()
      require('lspsaga').setup({})
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter', -- optional
      'nvim-tree/nvim-web-devicons'     -- optional
    }
  },
  -- plugins/rest.lua
  {
  "rest-nvim/rest.nvim",  -- Ensure the plugin name is uncommented
  dependencies = { "nvim-lua/plenary.nvim" },  -- Single-level dependency list is fine
  ft = "http",
  config = function()
    require("rest-nvim").setup({
      -- Add your configuration options here
    })
  end
},
  'xiyaowong/transparent.nvim',
  'psliwka/vim-smoothie',
  'ggandor/leap.nvim',
  -- 'smiteshp/nvim-gps',  -- Simple statusline component that shows what scope you are working inside
  'morhetz/gruvbox',
  'eddyekofo94/gruvbox-flat.nvim',
  'nvim-tree/nvim-tree.lua',
  'luisiacc/gruvbox-baby',

  -- ai tools
  'Exafunction/codeium.vim',
--   {
--     "Exafunction/codeium.nvim",
--     dependencies = {
--         "nvim-lua/plenary.nvim",
--         "hrsh7th/nvim-cmp",
--     },
--     config = function()
--         require("codeium").setup({
--         })
--     end
-- },
--   {
--     "Exafunction/codeium.nvim",
--     dependencies = {
--         "nvim-lua/plenary.nvim",
--         "hrsh7th/nvim-cmp",
--     },
--     config = function()
--         require("codeium").setup({
--         })
--     end
-- },
  -- lazy.nvim
  {
    -- https://github.com/Robitx/gp.nvim?tab=readme-ov-file#4-configuration
    "robitx/gp.nvim",
    config = function()
      local config = {
        api_key = os.getenv("OPENAI_API_KEY"),
      }
      -- Require and setup gp.nvim with the provided configuration
      require("gp").setup(config)

      -- or setup with your own config (see Install > Configuration in Readme)
      -- require("gp").setup(config)

      -- shortcuts might be setup here (see Usage > Shortcuts in Readme)
    end,
  },
  -- 'github/copilot.vim',
  --   {
  --   'zbirenbaum/copilot.lua', -- replacement for copilot
  --   cmd = "Copilot",
  --   event = "InsertEnter",
  --   config = function()
  --     require("copilot").setup({})
  --   end,
  -- },
  -- {
  --   "epwalsh/obsidian.nvim",
  --   version = "*",  -- recommended, use latest release instead of latest commit
  --   lazy = true,
  --   ft = "markdown",
  --   -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  --   -- event = {
  --   --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
  --   --   "BufReadPre path/to/my-vault/**.md",
  --   --   "BufNewFile path/to/my-vault/**.md",
  --   -- },
  --   dependencies = {
  --     -- Required.
  --     "nvim-lua/plenary.nvim",
  --
  --     -- see below for full list of optional dependencies 👇
  --   },
  --   opts = {
  --     workspaces = {
  --       {
  --         name = "personal",
  --         path = "~/vaults/personal",
  --       },
  --       {
  --         name = "work",
  --         path = "~/vaults/work",
  --       },
  --     },
  --
  --     -- see below for full list of options 👇
  --   },
  -- },


  {
    'SmiteshP/nvim-gps',
    dependencies = 'nvim-treesitter/nvim-treesitter',
  },
  -- {
  --   "jackMort/ChatGPT.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require("chatgpt").setup()
  --   end,
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "folke/trouble.nvim",
  --     "nvim-telescope/telescope.nvim"
  --   }
  -- },
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function ()
      require'alpha'.setup(require'alpha.themes.startify'.config)
    end
  },
{
  "mrjones2014/smart-splits.nvim",
  config = function()
    require("smart-splits").setup({
      at_edge = function(context)
        local dmap = {
          left = "prev",
          down = "south",
          up = "north",
          right = "next",
        }
        if context.mux.current_pane_at_edge(context.direction) then
          local ydirection = dmap[context.direction]
          local command = "yabai -m window --focus " .. ydirection .. " || $(yabai -m space --focus " .. ydirection .. ")"
          -- command = "yabai -m window --focus west || $(yabai -m display --focus west) || $(yabai -m space --focus prev)"

          -- if ydirection == "west" or ydirection == "east" then
          --   command = command .. " || $(yabai -m space --focus " .. ydirection .. ")"
          -- end

          vim.fn.system(command)
        end
      end,
    })
  end,
},
  'nocksock/do.nvim',

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { 'williamboman/mason.nvim', config = true },
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets
          -- This step is not supported in many windows environments
          -- Remove the below condition to re-enable on windows
          if vim.fn.has 'win32' == 1 then
            return
          end
          return 'make install_jsregexp'
        end)(),
      },
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },

  -- Useful plugin to show you pending keybinds.
  -- { 'folke/which-key.nvim', opts = {} },   -- HAD ERROR (closing nvim on g)--
  
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('config.gitsigns') -- Load the configuration
    end,
    dependencies = {
      'nvim-lua/plenary.nvim', -- Example dependency required by gitsigns.nvim
    },
  },
{
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
},
  -- {
  --   -- Set lualine as statusline
  --   'nvim-lualine/lualine.nvim',
  --   -- See `:help lualine.txt`
  --   opts = {
  --     options = {
  --       icons_enabled = false,
  --       theme = 'auto',
  --       component_separators = '|',
  --       section_separators = '',
  --     },
  --   },
  -- },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {},
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

'nvim-lua/popup.nvim',
'sudormrfbin/cheatsheet.nvim',
'onsails/lspkind.nvim',
'rcarriga/nvim-notify',
'glacambre/firenvim',
 -- lazy.nvim
 {
   "folke/noice.nvim",
   event = "VeryLazy",
   opts = {
     -- add any options here
   },
   dependencies = {
     -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
     "MunifTanjim/nui.nvim",
     -- OPTIONAL:
     --   `nvim-notify` is only needed, if you want to use the notification view.
     --   If not available, we use `mini` as the fallback
     "rcarriga/nvim-notify",
     }
 },
-- install with yarn or npm
{
  "iamcco/markdown-preview.nvim",
  cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  build = "cd app && yarn install",
  init = function()
    vim.g.mkdp_filetypes = { "markdown" }
  end,
  ft = { "markdown" },
},

  ----------- END -----------

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  -- { import = 'custom.plugins' },


  -- COMMENTED OUT PLUGINS --
  -- 'goolord/alpha-nvim',
  -- {
  --   'nvimdev/dashboard-nvim',
  --   event = 'VimEnter',
  --   config = function()
  --     require('dashboard').setup {
  --       -- config
  --     }
  --   end,
  --   dependencies = { {'nvim-tree/nvim-web-devicons'}}
  -- },
-- { 'mrjones2014/smart-splits.nvim' },
  -- {
  --   -- Theme inspired by Atom
  --   'navarasu/onedark.nvim',
  --   priority = 1000,
  --   lazy = false,
  --   config = function()
  --     require('onedark').setup {
  --       -- Set a style preset. 'dark' is default.
  --       style = 'dark', -- dark, darker, cool, deep, warm, warmer, light
  --     }
  --     require('onedark').load()
  --   end,
  -- },
}, {})
-- map a to elseif true theme_name
--

