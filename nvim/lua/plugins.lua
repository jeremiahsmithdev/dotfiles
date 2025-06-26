--[[
  Plugin Manager and Plugins Setup for Neovim

  This configuration uses lazy.nvim as the plugin manager to handle all plugins.
  See: https://github.com/folke/lazy.nvim
  For further configuration info, see :help lazy.nvim.txt
]]--

-- [] TODOS
-- trouble.nvim?

-- Install lazy.nvim if not present
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

--[[
Plugin List and Configuration
- List of plugins and their setup/config blocks, declared with require('lazy').setup({...})
- Some plugins have dependencies, options (opts), or config functions for setup
- Commented sections indicate optional or alternative plugins/configurations
]]--

require('lazy').setup({
  -- Plugin to live preview markdown and other files
  'sindrets/diffview.nvim',
  { 'echasnovski/mini.diff', version = false },
-- Inside your plugin spec or config
{
  "nvim-lua/plenary.nvim",
  config = function()
    vim.api.nvim_create_user_command("DiffAll", function()
      require("custom.gitdiff").open_git_diffs()
    end, {})
  end,
},
  {
    'brianhuster/live-preview.nvim',
    dependencies = {
      -- Require any one of the below picker plugins
      'nvim-telescope/telescope.nvim',
      'ibhagwan/fzf-lua',
      'echasnovski/mini.pick',
    },
  },

  -- Plugin to interface and work with remote servers/hosts
  {
    "amitds1997/remote-nvim.nvim",
    version = "*", -- Pin to GitHub releases
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = true,
  },

  -- AI Code Assistant Plugin
  {
    "olimorris/codecompanion.nvim",
    opts = {},
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },

  -- MCP Server (Model Context Protocol)
  {
    "ravitemer/mcphub.nvim",
    build = "npm install -g mcp-hub@latest",
    config = function()
      require("mcphub").setup()
    end,
  },

  -- Highlight and search TODO, FIX, WARNING, etc. comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      -- Custom configuration goes here
      -- Leave empty for defaults
    },
  },

  -- Easy image pasting for markdown and chat buffers
  {
    "HakonHarnes/img-clip.nvim",
    opts = {
      filetypes = {
        codecompanion = {
          prompt_for_file_name = false,
          template = "[Image]($FILE_PATH)",
          use_absolute_path = true,
        },
      },
    },
  },

  -- General utility plugins
  'nvim-lua/plenary.nvim',
  'kdheepak/lazygit.nvim',
  -- Flutter development suite
  {
    'nvim-flutter/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim',
    },
    config = true,
  },
  'famiu/nvim-reload',

  -- LSP UI features (code actions, diagnostics, etc.)
  {
    'nvimdev/lspsaga.nvim',
    config = function()
      require('lspsaga').setup({})
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
  },

  -- HTTP client for Neovim
  {
    "rest-nvim/rest.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    ft = "http",
    config = function()
      require("rest-nvim").setup({
        -- Configuration options can be set here
      })
    end,
  },

  'andymass/vim-matchup', -- Better % navigation
  'xiyaowong/transparent.nvim', -- Toggle transparency
  'karb94/neoscroll.nvim',      -- Smooth scrolling
  'ggandor/leap.nvim',          -- Motion plugin (jump anywhere)
  -- 'morhetz/gruvbox',            -- Color scheme
  { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts = ...},
  'nvim-tree/nvim-tree.lua',    -- File explorer

  -- AI/Code completion tools
  'Exafunction/windsurf.vim',

  -- ChatGPT and OpenAI plugin
  {
    "robitx/gp.nvim",
    config = function()
      local config = {
        api_key = os.getenv("OPENAI_API_KEY"),
      }
      require("gp").setup(config)
    end,
  },

  -- Statusline scope plugin
  {
    'SmiteshP/nvim-gps',
    dependencies = 'nvim-treesitter/nvim-treesitter',
  },

  -- Dashboard and welcome screen
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require'alpha'.setup(require'alpha.themes.startify'.config)
    end,
  },
--   {
--   'nvimdev/dashboard-nvim',
--   event = 'VimEnter',
--   config = function()
--     require('dashboard').setup {
--       -- config
--     }
--   end,
--   dependencies = { {'nvim-tree/nvim-web-devicons'}}
-- },

  -- Smart splits across windows and tmux/yabai, with macOS integration
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
            vim.fn.system(command)
          end
        end,
      })
    end,
  },

  -- Personal task management within Neovim
  {
    "Hashino/doing.nvim",
    config = function()
      require("doing").setup {
        message_timeout = 2000,
        doing_prefix = "Doing: ",
        ignored_buffers = { "NvimTree" },
        show_remaining = true,
        show_messages = true,
        edit_win_config = {
          width = 50,
          height = 15,
          border = "rounded",
        },
        winbar = { enabled = false, },
        store = {
          sync_tasks = true,
        --   use_global_store = true, -- use a global tasks file instead of per-project
        --   global_file_path = "~/.doing_tasks"  -- or any preferred patIh
        --   -- file_name = ".doing_tasks",
        },
      }
      vim.api.nvim_set_hl(0, "WinBar", { link = "Search" })
      local doing = require("doing")
      vim.keymap.set("n", "<leader>da", doing.add, { desc = "[D]oing: [A]dd" })
      vim.keymap.set("n", "<leader>de", doing.edit, { desc = "[D]oing: [E]dit" })
      vim.keymap.set("n", "<leader>dn", doing.done, { desc = "[D]oing: Do[n]e" })
      vim.keymap.set("n", "<leader>dt", doing.toggle, { desc = "[D]oing: [T]oggle" })
      vim.cmd("cabbrev de Do edit")
      vim.cmd("cabbrev da Do add")
      vim.cmd("cabbrev dt Do toggle")
      vim.cmd("cabbrev dn Do done")
      vim.keymap.set("n", "<leader>ds", function()
        vim.notify(doing.status(true), vim.log.levels.INFO, { title = "Doing:", icon = "", })
      end, { desc = "[D]oing: [S]tatus", })
    end,
  },

  -- Git integration plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Smart tab/shiftwidth detection
  'tpope/vim-sleuth',

  -- LSP configuration and dependencies
  {
    "mason-org/mason-lspconfig.nvim",
    ensure_installed = {'intelephense'},
    opts = {},
    dependencies = {
        { "mason-org/mason.nvim", opts = {} },
        "neovim/nvim-lspconfig",
        { 'j-hui/fidget.nvim', opts = {} }, --?
        'folke/neodev.nvim', --?
    },
  },
  -- {
  --   'neovim/nvim-lspconfig',
  --   dependencies = {
  --     { 'williamboman/mason.nvim', config = true },
  --     'williamboman/mason-lspconfig.nvim',
  --     { 'j-hui/fidget.nvim', opts = {} },
  --     'folke/neodev.nvim',
  --   },
  -- },

  -- Autocompletion plugins (nvim-cmp suite)
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          if vim.fn.has 'win32' == 1 then
            return
          end
          return 'make install_jsregexp'
        end)(),
      },
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'rafamadriz/friendly-snippets',
    },
  },

  -- Show keybindings in a popup
  -- { 'folke/which-key.nvim', opts = {} },

  -- GitSigns: show modifcations in sign column
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('config.gitsigns')
    end,
    dependencies = { 'nvim-lua/plenary.nvim' },
  },

  -- Statusline plugin
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },

  -- Add indentation guides
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {},
  },

  -- Commenting utility
  { 'numToStr/Comment.nvim', opts = {} },

  -- Fuzzy finder and its native fzf extension
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  -- TreeSitter configs for syntax highlighting, code navigation
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    build = ':TSUpdate',
  },

  -- Helper plugins and utilities
  'nvim-lua/popup.nvim',
  'sudormrfbin/cheatsheet.nvim',
  'onsails/lspkind.nvim',
  'rcarriga/nvim-notify',
  'glacambre/firenvim',
  'vuciv/vim-bujo',

  -- Highly customisable notifications, messages and command UI
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {},
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
  },

  -- Live Markdown Preview plugin
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  -- Lightweight code-assistant, default is lazy-loaded for <leader>cc
  {
    'johnseth97/codex.nvim',
    lazy = true,
    keys = {
      {
        '<leader>cc',
        function() require('codex').toggle() end,
        desc = 'Toggle Codex popup',
      },
    },
    opts = {
      keymaps     = {},
      border      = 'rounded',
      width       = 0.8,
      height      = 0.8,
      autoinstall = true,
    },
  },

  -- Markdown rendering in codecompanion/chat and markdown buffers
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion" },
  },
{
    "GeorgesAlkhouri/nvim-aider",
    cmd = "Aider",
    -- Example key mappings for common actions:
    keys = {
      { "<leader>a/", "<cmd>Aider toggle<cr>", desc = "Toggle Aider" },
      { "<leader>as", "<cmd>Aider send<cr>", desc = "Send to Aider", mode = { "n", "v" } },
      { "<leader>ac", "<cmd>Aider command<cr>", desc = "Aider Commands" },
      { "<leader>ab", "<cmd>Aider buffer<cr>", desc = "Send Buffer" },
      { "<leader>a+", "<cmd>Aider add<cr>", desc = "Add File" },
      { "<leader>a-", "<cmd>Aider drop<cr>", desc = "Drop File" },
      { "<leader>ar", "<cmd>Aider add readonly<cr>", desc = "Add Read-Only" },
      { "<leader>aR", "<cmd>Aider reset<cr>", desc = "Reset Session" },
      -- Example nvim-tree.lua integration if needed
      { "<leader>a+", "<cmd>AiderTreeAddFile<cr>", desc = "Add File from Tree to Aider", ft = "NvimTree" },
      { "<leader>a-", "<cmd>AiderTreeDropFile<cr>", desc = "Drop File from Tree from Aider", ft = "NvimTree" },
    },
    dependencies = {
      "folke/snacks.nvim",
      --- The below dependencies are optional
      "catppuccin/nvim",
      "nvim-tree/nvim-tree.lua",
      --- Neo-tree integration
      {
        "nvim-neo-tree/neo-tree.nvim",
        opts = function(_, opts)
          -- Example mapping configuration (already set by default)
          -- opts.window = {
          --   mappings = {
          --     ["+"] = { "nvim_aider_add", desc = "add to aider" },
          --     ["-"] = { "nvim_aider_drop", desc = "drop from aider" }
          --     ["="] = { "nvim_aider_add_read_only", desc = "add read-only to aider" }
          --   }
          -- }
          require("nvim_aider.neo_tree").setup(opts)
        end,
      },
    },
    config = true,
  }

}, {})

-- END OF PLUGIN SETUP

