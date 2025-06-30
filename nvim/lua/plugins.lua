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
  -- Essential dependency for many plugins
  'nvim-lua/plenary.nvim',

  -- Git diff viewer
  {
    'sindrets/diffview.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewToggleFiles', 'DiffviewFocusFiles' },
    config = function()
      vim.api.nvim_create_user_command("DiffAll", function()
        require("custom.gitdiff").open_git_diffs()
      end, {})
    end,
  },
  
  -- Mini diff for inline git changes
  { 
    'echasnovski/mini.diff', 
    version = false,
    event = 'BufReadPre',
  },
  -- Live preview for markdown and other files
  {
    'brianhuster/live-preview.nvim',
    ft = { 'markdown', 'html' },
    dependencies = { 'nvim-telescope/telescope.nvim' },
  },

  -- Debug Adapter Protocol
  {
    'mfussenegger/nvim-dap',
    keys = {
      { '<F5>', function() require('dap').continue() end, desc = 'DAP Continue' },
      { '<F10>', function() require('dap').step_over() end, desc = 'DAP Step Over' },
      { '<F11>', function() require('dap').step_into() end, desc = 'DAP Step Into' },
      { '<F12>', function() require('dap').step_out() end, desc = 'DAP Step Out' },
      { '<Leader>b', function() require('dap').toggle_breakpoint() end, desc = 'DAP Toggle Breakpoint' },
    },
    config = function()
      require('config.dap')
    end,
  },

  -- DAP UI
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    keys = {
      { '<leader>du', function() require('dapui').open() end, desc = 'DAP UI Open' },
      { '<leader>dc', function() require('dapui').close() end, desc = 'DAP UI Close' },
      { '<leader>dt', function() require('dapui').toggle() end, desc = 'DAP UI Toggle' },
    },
    config = function()
      require("dapui").setup()
    end
  },
  -- Remote development plugin
  {
    "amitds1997/remote-nvim.nvim",
    version = "*",
    cmd = { "RemoteStart", "RemoteStop", "RemoteInfo" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = true,
  },

  -- Primary AI Code Assistant
  {
    "olimorris/codecompanion.nvim",
    cmd = { "CodeCompanion", "CodeCompanionActions", "CodeCompanionToggle", "CodeCompanionAdd" },
    keys = {
      { "<leader>cc", "<cmd>CodeCompanionActions<cr>", desc = "CodeCompanion Actions", mode = { "n", "v" } },
      { "<leader>ct", "<cmd>CodeCompanionToggle<cr>", desc = "CodeCompanion Toggle" },
      { "<leader>ca", "<cmd>CodeCompanionAdd<cr>", desc = "CodeCompanion Add", mode = "v" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "hrsh7th/nvim-cmp",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require('config.codecompanion')
    end,
  },

  -- MCP Server (Model Context Protocol) - Enhanced
  {
    "ravitemer/mcphub.nvim",
    cmd = { "McpHub", "McpHubConnect", "McpHubList", "McpHubStatus" },
    keys = {
      { "<leader>mc", "<cmd>McpHubConnect<cr>", desc = "MCP Connect" },
      { "<leader>ml", "<cmd>McpHubList<cr>", desc = "MCP List Servers" },
      { "<leader>ms", "<cmd>McpHubStatus<cr>", desc = "MCP Status" },
    },
    dependencies = { "nvim-lua/plenary.nvim" },
    build = "npm install -g mcp-hub@latest",
    config = function()
      require("mcphub").setup({
        servers = {
          filesystem = {
            command = "npx",
            args = { "@modelcontextprotocol/server-filesystem", vim.fn.getcwd() },
          },
          git = {
            command = "npx", 
            args = { "@modelcontextprotocol/server-git", "--repository", vim.fn.getcwd() },
          },
        },
        auto_connect = true,
        log_level = "info",
      })
    end
  },
  -- Highlight and search TODO, FIX, WARNING, etc. comments
  -- PERF: Fully optimized
  -- HACK: Temporary workaround
  -- TODO: Fix crash on null pointer
  -- NOTE: This is important
  -- FIX: This needs fixing
  -- BUG: bug
  -- ISSUE: issue
  -- WARNING: Warning message
  -- TEST: Test message
  -- TESTING: 
  -- PASSED: 
  -- FAILED:

  -- TODO comments highlighting and search
  {
    "folke/todo-comments.nvim",
    event = "BufReadPre",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>xt", "<cmd>TodoTelescope<CR>", desc = "Todo (Telescope)" },
      { "<leader>xT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<CR>", desc = "Todo/Fix/Fixme" },
    },
    opts = {
      keywords = {
        FIX = {
          icon = " ",
          color = "#FF2222",
          alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
        },
        TODO = { icon = " ", color = "#2AA9F9" },
        HACK = { icon = " ", color = "#FF8800" },
        WARN = { icon = " ", color = "#FFFF00", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", color = "#7C3AED", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "#00FFAA", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "#5EEA37", alt = { "TESTING", "PASSED", "FAILED" } },
      },
    }
  },

  -- Easy image pasting for markdown and chat buffers
  {
    "HakonHarnes/img-clip.nvim",
    ft = { "markdown", "codecompanion" },
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

  -- LazyGit integration
  {
    'kdheepak/lazygit.nvim',
    cmd = { "LazyGit", "LazyGitConfig", "LazyGitCurrentFile", "LazyGitFilter", "LazyGitFilterCurrentFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  -- Flutter development suite
  {
    'nvim-flutter/flutter-tools.nvim',
    ft = { 'dart' },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim',
    },
    config = true,
  },

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

  -- Better % navigation
  {
    'andymass/vim-matchup',
    event = 'BufReadPost',
  },

  -- Toggle transparency
  {
    'xiyaowong/transparent.nvim',
    cmd = { 'TransparentEnable', 'TransparentDisable', 'TransparentToggle' },
    config = function()
      require('transparent').setup()
    end,
  },

  -- Smooth scrolling
  {
    'karb94/neoscroll.nvim',
    event = 'BufReadPost',
    config = function()
      require('config.neoscroll')
    end,
  },

  -- Motion plugin (jump anywhere)
  {
    'ggandor/leap.nvim',
    keys = { 's', 'S', 'gs' },
    config = function()
      require('leap').add_default_mappings()
    end,
  },

  -- Gruvbox colorscheme
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    lazy = false,
    config = function()
      require('gruvbox').setup()
      vim.cmd('colorscheme gruvbox')
    end,
  },

  -- File explorer
  {
    'nvim-tree/nvim-tree.lua',
    cmd = { 'NvimTreeToggle', 'NvimTreeOpen', 'NvimTreeFocus' },
    keys = {
      { '<leader>e', '<cmd>NvimTreeToggle<cr>', desc = 'Toggle NvimTree' },
    },
    config = function()
      require("nvim-tree").setup()
    end,
  },

  -- AI/Code completion tools
  'Exafunction/windsurf.vim',

  -- Secondary AI assistant (optional)
  {
    "robitx/gp.nvim",
    cmd = { "GpChatNew", "GpChatPaste", "GpChatToggle" },
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
    keys = {
      -- Navigation
      { '<C-h>', function() require('smart-splits').move_cursor_left() end, desc = 'Move cursor left' },
      { '<C-j>', function() require('smart-splits').move_cursor_down() end, desc = 'Move cursor down' },
      { '<C-k>', function() require('smart-splits').move_cursor_up() end, desc = 'Move cursor up' },
      { '<C-l>', function() require('smart-splits').move_cursor_right() end, desc = 'Move cursor right' },
      -- Resizing
      { '<A-h>', function() require('smart-splits').resize_left() end, desc = 'Resize left' },
      { '<A-j>', function() require('smart-splits').resize_down() end, desc = 'Resize down' },
      { '<A-k>', function() require('smart-splits').resize_up() end, desc = 'Resize up' },
      { '<A-l>', function() require('smart-splits').resize_right() end, desc = 'Resize right' },
      -- Swapping
      { '<A-H>', function() require('smart-splits').swap_buf_left() end, desc = 'Swap buffer left' },
      { '<A-J>', function() require('smart-splits').swap_buf_down() end, desc = 'Swap buffer down' },
      { '<A-K>', function() require('smart-splits').swap_buf_up() end, desc = 'Swap buffer up' },
      { '<A-L>', function() require('smart-splits').swap_buf_right() end, desc = 'Swap buffer right' },
    },
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
  {
    'tpope/vim-fugitive',
    cmd = { 'Git', 'Gstatus', 'Gblame', 'Gpush', 'Gpull' },
  },
  {
    'tpope/vim-rhubarb',
    dependencies = { 'tpope/vim-fugitive' },
  },

  -- Smart tab/shiftwidth detection
  {
    'tpope/vim-sleuth',
    event = 'BufReadPre',
  },

  -- Codeium AI completion
  {
    'Exafunction/codeium.nvim',
    event = 'InsertEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'hrsh7th/nvim-cmp',
    },
    config = function()
      require('config.codeium')
    end,
  },

  -- LSP configuration and dependencies
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      {
        'williamboman/mason.nvim',
        cmd = 'Mason',
        config = true,
      },
      {
        'williamboman/mason-lspconfig.nvim',
        opts = {
          ensure_installed = { 'lua_ls', 'intelephense' },
        },
      },
      {
        'j-hui/fidget.nvim',
        opts = {},
      },
      'folke/neodev.nvim',
    },
    config = function()
      require('config.lsp')
    end,
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          if vim.fn.has 'win32' == 1 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = { 'rafamadriz/friendly-snippets' },
      },
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
    },
    config = function()
      require('config.cmp')
    end,
  },

  -- Show keybindings in a popup
  -- { 'folke/which-key.nvim', opts = {} },

  -- GitSigns: show modifications in sign column
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufReadPre',
    config = function()
      require('config.gitsigns')
    end,
  },

  -- Statusline plugin
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('config.lualine')
    end,
  },

  -- Add indentation guides
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufReadPost',
    main = 'ibl',
    opts = {},
  },

  -- Commenting utility
  {
    'numToStr/Comment.nvim',
    keys = {
      { 'gc', mode = { 'n', 'v' }, desc = 'Comment toggle linewise' },
      { 'gb', mode = { 'n', 'v' }, desc = 'Comment toggle blockwise' },
    },
    opts = {},
  },
  {
    "greggh/claude-code.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for git operations
    },
    config = function()
      require("claude-code").setup()
    end
  },

  -- Fuzzy finder
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    cmd = 'Telescope',
    keys = {
      { '<C-g>', '<cmd>Telescope live_grep<cr>', desc = 'Live Grep' },
      { '<leader>sf', '<cmd>Telescope find_files<cr>', desc = 'Search Files' },
      { '<leader>sg', '<cmd>Telescope live_grep<cr>', desc = 'Search by Grep' },
      { '<leader>sb', '<cmd>Telescope buffers<cr>', desc = 'Search Buffers' },
      { '<leader>sh', '<cmd>Telescope help_tags<cr>', desc = 'Search Help' },
    },
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
    config = function()
      require('config.telescope')
    end,
  },

  -- TreeSitter for syntax highlighting and code navigation
  {
    'nvim-treesitter/nvim-treesitter',
    event = { 'BufReadPost', 'BufNewFile' },
    dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
    build = ':TSUpdate',
    config = function()
      require('config.treesitter')
    end,
  },

  -- Helper plugins and utilities
  {
    'onsails/lspkind.nvim',
    event = 'InsertEnter',
    config = function()
      require('config.lspkind')
    end,
  },

  -- Notifications
  {
    'rcarriga/nvim-notify',
    event = 'VeryLazy',
    config = function()
      vim.notify = require("notify")
      require("notify").setup({
        background_colour = "#1a1b26",
      })
    end,
  },

  -- Browser integration
  {
    'glacambre/firenvim',
    lazy = not vim.g.started_by_firenvim,
    build = function()
      vim.fn["firenvim#install"](0)
    end,
    config = function()
      require("config.firenvim")
    end,
  },

  -- Enhanced UI for messages, cmdline and popupmenu
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require('config.noice')
    end,
  },

  -- Live Markdown Preview
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
  },

  -- Markdown rendering in buffers
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion" },
  },
  -- Enhanced Avante AI Assistant
  -- {
  --   "yetone/avante.nvim",
  --   event = "VeryLazy",
  --   version = false,
  --   config = function()
  --     require('config.avante')
  --   end,
  --   build = "make",
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --     "stevearc/dressing.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --     "nvim-telescope/telescope.nvim",
  --     "hrsh7th/nvim-cmp",
  --     "nvim-tree/nvim-web-devicons",
  --     {
  --       "HakonHarnes/img-clip.nvim",
  --       event = "VeryLazy",
  --       opts = {
  --         default = {
  --           embed_image_as_base64 = false,
  --           prompt_for_file_name = false,
  --           drag_and_drop = { insert_mode = true },
  --           use_absolute_path = true,
  --         },
  --       },
  --     },
  --   },
  -- },

  -- Session and Context Persistence
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = {
      dir = vim.fn.expand(vim.fn.stdpath("state") .. "/sessions/"),
      options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp" },
      pre_save = function()
        -- Save AI context before session save
        local ai_context = vim.g.ai_context or {}
        ai_context.timestamp = os.time()
        ai_context.cwd = vim.fn.getcwd()
        ai_context.git_branch = vim.fn.system("git branch --show-current"):gsub("\n", "")
        vim.g.ai_context = ai_context
      end,
    },
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
  },

  -- Aider AI coding assistant integration
  {
    "GeorgesAlkhouri/nvim-aider",
    cmd = "Aider",
    keys = {
      { "<leader>a/", "<cmd>Aider toggle<cr>", desc = "Toggle Aider" },
      { "<leader>as", "<cmd>Aider send<cr>", desc = "Send to Aider", mode = { "n", "v" } },
      { "<leader>ac", "<cmd>Aider command<cr>", desc = "Aider Commands" },
      { "<leader>ab", "<cmd>Aider buffer<cr>", desc = "Send Buffer" },
      { "<leader>a+", "<cmd>Aider add<cr>", desc = "Add File" },
      { "<leader>a-", "<cmd>Aider drop<cr>", desc = "Drop File" },
      { "<leader>ar", "<cmd>Aider add readonly<cr>", desc = "Add Read-Only" },
      { "<leader>aR", "<cmd>Aider reset<cr>", desc = "Reset Session" },
    },
    dependencies = {
      "folke/snacks.nvim",
      "nvim-tree/nvim-tree.lua",
    },
    config = true,
  }

}, {})

-- END OF PLUGIN SETUP

