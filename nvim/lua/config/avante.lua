-- Avante AI Assistant Configuration
-- Enhanced AI coding assistant with multiple provider support

require('avante').setup({
  -- Use Claude as the primary provider (requires ANTHROPIC_API_KEY)
  -- If you don't have ANTHROPIC_API_KEY, change this to "openai"
  provider = "openai",
  
  -- Provider configurations (new format)
  providers = {
    claude = {
      endpoint = "https://api.anthropic.com",
      model = "claude-3-5-sonnet-20241022",
      timeout = 30000,
      extra_request_body = {
        temperature = 0,
        max_tokens = 8192,
      },
    },
    
    openai = {
      endpoint = "https://api.openai.com/v1",
      model = "gpt-4o",
      timeout = 30000,
      extra_request_body = {
        temperature = 0,
        max_tokens = 4096,
      },
    },
  },
  
  -- Behavior settings
  behaviour = {
    auto_suggestions = true,
    auto_set_highlight_group = true,
    auto_set_keymaps = true,
    auto_apply_diff_after_generation = false,
    support_paste_from_clipboard = true,
  },
  
  -- Key mappings
  mappings = {
    ask = "<leader>aa",
    edit = "<leader>ae", 
    refresh = "<leader>ar",
    diff = {
      ours = "co",
      theirs = "ct",
      all_theirs = "ca",
      both = "cb",
      cursor = "cc",
      next = "]x",
      prev = "[x",
    },
  },
  
  -- Window settings
  windows = {
    position = "right",
    wrap = true,
    width = 30,
    sidebar_header = {
      align = "center",
      rounded = true,
    },
  },
  
  -- Hints and suggestions
  hints = {
    enabled = true,
  },
})

-- Optional: Create a command to switch providers easily
vim.api.nvim_create_user_command('AvanteProvider', function(opts)
  local provider = opts.args
  if provider == "" then
    -- Try to get current provider safely
    local ok, config = pcall(require, 'avante.config')
    if ok and config.provider then
      print("Current provider: " .. config.provider)
    else
      print("Current provider: unknown")
    end
    print("Available providers: claude, openai")
    return
  end
  
  local valid_providers = { "claude", "openai" }
  if vim.tbl_contains(valid_providers, provider) then
    local ok, config = pcall(require, 'avante.config')
    if ok then
      config.provider = provider
      print("Switched to provider: " .. provider)
    else
      print("Error: Could not access Avante config")
    end
  else
    print("Invalid provider. Available: " .. table.concat(valid_providers, ", "))
  end
end, {
  nargs = '?',
  complete = function()
    return { "claude", "openai" }
  end,
  desc = "Switch Avante AI provider"
})
