-- Unified AI Configuration and Context Management
local M = {}

-- Centralized AI configuration
M.providers = {
  primary = "claude_cli", -- Using Claude Code CLI
  fallback = "openai", 
  ["local"] = "ollama",
  completion = "codeium",
}

M.models = {
  claude = "claude-3-5-sonnet-20241022",
  openai = "gpt-4o",
  ollama = "codellama:13b",
  codeium = "codeium",
}

-- Provider configurations for Avante
M.provider_configs = {
  claude_cli = {
    -- Claude CLI configuration
    command = "claude",
    args = function(prompt)
      return { prompt }
    end,
  },
  claude = {
    endpoint = "https://api.anthropic.com",
    model = "claude-3-5-sonnet-20241022",
    extra = {
      temperature = 0,
    },
    extra_request_body = {
      max_tokens = 8192,
    },
  },
  openai = {
    endpoint = "https://api.openai.com/v1",
    model = "gpt-4o",
    extra = {
      temperature = 0.1,
    },
    extra_request_body = {
      max_tokens = 4096,
    },
  },
  ollama = {
    endpoint = "http://127.0.0.1:11434/v1",
    model = "codellama:13b",
    extra = {
      temperature = 0.2,
    },
    extra_request_body = {
      max_tokens = 2048,
    },
  },
}

M.contexts = {
  max_tokens = 8192,
  temperature = 0.1,
  top_p = 0.9,
  max_context_files = 10,
}

-- AI Mode state
M.ai_mode = false
M.current_context = {}

-- Get comprehensive project context
function M.get_project_context()
  local context = {}
  
  -- Git context
  local git_branch = vim.fn.system("git branch --show-current 2>/dev/null"):gsub("\n", "")
  local git_status = vim.fn.system("git status --porcelain 2>/dev/null")
  local git_commits = vim.fn.system("git log --oneline -5 2>/dev/null")
  
  context.git = {
    branch = git_branch ~= "" and git_branch or "not-a-git-repo",
    status = git_status,
    recent_commits = git_commits,
    root = vim.fn.system("git rev-parse --show-toplevel 2>/dev/null"):gsub("\n", ""),
  }
  
  -- File context
  context.files = {
    current = vim.api.nvim_buf_get_name(0),
    current_relative = vim.fn.expand("%"),
    modified = vim.fn.system("git diff --name-only 2>/dev/null"),
    project_root = vim.fn.getcwd(),
    filetype = vim.bo.filetype,
  }
  
  -- LSP context
  local clients = vim.lsp.get_active_clients({ bufnr = 0 })
  context.lsp = {}
  for _, client in ipairs(clients) do
    table.insert(context.lsp, {
      name = client.name,
      root_dir = client.config.root_dir,
    })
  end
  
  -- Buffer context
  context.buffer = {
    lines = vim.api.nvim_buf_line_count(0),
    cursor = vim.api.nvim_win_get_cursor(0),
    selection = M.get_visual_selection(),
    diagnostics = #vim.diagnostic.get(0),
  }
  
  -- Project structure (limited for performance)
  local tree_output = vim.fn.system("tree -L 2 -I 'node_modules|.git|__pycache__|.venv' 2>/dev/null")
  context.structure = tree_output ~= "" and tree_output or "No tree command available"
  
  return context
end

-- Get visual selection text
function M.get_visual_selection()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  
  if start_pos[2] == 0 or end_pos[2] == 0 then
    return nil
  end
  
  local lines = vim.api.nvim_buf_get_lines(0, start_pos[2] - 1, end_pos[2], false)
  if #lines == 0 then
    return nil
  end
  
  -- Handle single line selection
  if #lines == 1 then
    lines[1] = string.sub(lines[1], start_pos[3], end_pos[3])
  else
    -- Handle multi-line selection
    lines[1] = string.sub(lines[1], start_pos[3])
    lines[#lines] = string.sub(lines[#lines], 1, end_pos[3])
  end
  
  return table.concat(lines, "\n")
end

-- Smart provider selection based on context
function M.smart_provider_selection()
  local line = vim.api.nvim_get_current_line()
  local filetype = vim.bo.filetype
  local selection = M.get_visual_selection()
  
  -- Documentation tasks -> Claude
  if filetype == "markdown" or 
     line:match("^%s*#") or 
     line:match("^%s*//") or
     line:match("^%s*%*") or
     (selection and selection:match("TODO") or selection and selection:match("FIXME")) then
    return M.providers.primary
  end
  
  -- Code generation/review -> OpenAI
  if filetype == "python" or 
     filetype == "javascript" or 
     filetype == "typescript" or
     filetype == "lua" or
     filetype == "rust" or
     filetype == "go" then
    return M.providers.fallback
  end
  
  -- Quick completions -> Codeium
  if vim.fn.mode() == "i" then
    return M.providers.completion
  end
  
  -- Default to primary
  return M.providers.primary
end

-- Toggle AI mode with visual feedback
function M.toggle_ai_mode()
  M.ai_mode = not M.ai_mode
  
  if M.ai_mode then
    vim.notify("🤖 AI Mode Enabled", vim.log.levels.INFO, { title = "AI Workflow" })
    M.setup_ai_keymaps()
    M.current_context = M.get_project_context()
  else
    vim.notify("✋ Manual Mode Enabled", vim.log.levels.INFO, { title = "AI Workflow" })
    M.cleanup_ai_keymaps()
    M.current_context = {}
  end
  
  -- Update statusline indicator
  vim.g.ai_mode_active = M.ai_mode
end

-- Set up AI-specific keymaps
function M.setup_ai_keymaps()
  local opts = { buffer = true, silent = true }
  
  -- Quick AI actions
  vim.keymap.set('n', '<CR>', function() M.smart_ai_action() end, 
    vim.tbl_extend('force', opts, { desc = 'Smart AI Action' }))
  vim.keymap.set('v', '<CR>', function() M.smart_ai_action() end, 
    vim.tbl_extend('force', opts, { desc = 'Smart AI Action (Visual)' }))
  
  -- Context-aware suggestions
  vim.keymap.set('n', '<Tab>', function() M.ai_suggest() end,
    vim.tbl_extend('force', opts, { desc = 'AI Suggest' }))
  
  -- Quick explanations
  vim.keymap.set('n', '?', function() M.explain_current() end,
    vim.tbl_extend('force', opts, { desc = 'AI Explain' }))
end

-- Clean up AI-specific keymaps
function M.cleanup_ai_keymaps()
  local keymaps_to_remove = { '<CR>', '<Tab>', '?' }
  
  for _, key in ipairs(keymaps_to_remove) do
    pcall(vim.keymap.del, 'n', key, { buffer = true })
    pcall(vim.keymap.del, 'v', key, { buffer = true })
  end
end

-- Smart AI action based on context
function M.smart_ai_action()
  local mode = vim.fn.mode()
  local line = vim.api.nvim_get_current_line()
  local selection = M.get_visual_selection()
  
  if mode == 'v' or mode == 'V' or selection then
    -- Visual mode - analyze selection
    vim.cmd('CodeCompanionActions')
  elseif line:match("^%s*#") or line:match("^%s*//") then
    -- Comment line - generate code from comment
    vim.cmd('Gen Generate_Code')
  elseif line:match("TODO") or line:match("FIXME") or line:match("HACK") then
    -- TODO item - provide suggestions
    vim.cmd('Gen Enhance_Code')
  elseif line:match("def ") or line:match("function ") or line:match("class ") then
    -- Function/class definition - generate documentation
    vim.cmd('Gen Generate_Docstring')
  elseif vim.bo.filetype == "markdown" then
    -- Markdown - continue writing
    vim.cmd('CodeCompanionToggle')
  else
    -- Default - open chat
    vim.cmd('CodeCompanionToggle')
  end
end

-- AI-powered suggestions for current context
function M.ai_suggest()
  local context = M.get_project_context()
  local current_line = vim.api.nvim_get_current_line()
  
  -- Create context string
  local context_str = string.format(
    "File: %s\nLine: %s\nFiletype: %s\nGit branch: %s",
    context.files.current_relative,
    current_line,
    context.files.filetype,
    context.git.branch
  )
  
  -- Send to AI for suggestions
  vim.cmd('CodeCompanion ' .. vim.fn.shellescape('Suggest improvements for: ' .. context_str))
end

-- Explain current context
function M.explain_current()
  local selection = M.get_visual_selection()
  local line = vim.api.nvim_get_current_line()
  local target = selection or line
  
  if target and target:trim() ~= "" then
    vim.cmd('CodeCompanion ' .. vim.fn.shellescape('Explain this code: ' .. target))
  else
    vim.notify("Nothing to explain", vim.log.levels.WARN)
  end
end

-- Get context for MCP servers
function M.get_mcp_context()
  local context = M.get_project_context()
  
  return {
    workspace = {
      root = context.files.project_root,
      files = vim.split(context.files.modified, "\n"),
      current_file = context.files.current_relative,
    },
    git = context.git,
    lsp_servers = context.lsp,
    diagnostics_count = context.buffer.diagnostics,
  }
end

-- Switch AI provider dynamically
function M.switch_provider(provider)
  if not M.provider_configs[provider] then
    vim.notify("Unknown provider: " .. provider, vim.log.levels.ERROR)
    return
  end
  
  M.providers.primary = provider
  vim.g.ai_current_provider = provider
  
  -- Update Avante configuration if available
  local avante_ok, avante = pcall(require, 'avante')
  if avante_ok then
    avante.setup({
      provider = provider,
      providers = M.provider_configs,
    })
  end
  
  vim.notify("Switched to " .. provider .. " provider", vim.log.levels.INFO)
end

-- Get available providers
function M.get_available_providers()
  return vim.tbl_keys(M.provider_configs)
end

-- Provider selection menu
function M.select_provider()
  local providers = M.get_available_providers()
  vim.ui.select(providers, {
    prompt = "Select AI Provider:",
    format_item = function(item)
      local current = item == M.providers.primary and " (current)" or ""
      return item .. current
    end,
  }, function(choice)
    if choice then
      M.switch_provider(choice)
    end
  end)
end

-- Initialize AI workflow
function M.setup()
  -- Set up autocommands for context updates
  vim.api.nvim_create_augroup("AIWorkflow", { clear = true })
  
  -- Update context on file changes
  vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
    group = "AIWorkflow",
    callback = function()
      if M.ai_mode then
        M.current_context = M.get_project_context()
      end
    end,
  })
  
  -- Auto-disable AI mode on certain filetypes
  vim.api.nvim_create_autocmd("FileType", {
    group = "AIWorkflow",
    pattern = { "help", "man", "qf", "oil" },
    callback = function()
      if M.ai_mode then
        M.ai_mode = false
        M.cleanup_ai_keymaps()
        vim.notify("AI Mode disabled for this filetype", vim.log.levels.INFO)
      end
    end,
  })
  
  -- Set up global keymaps
  vim.keymap.set('n', '<leader>am', M.toggle_ai_mode, { desc = 'Toggle AI Mode' })
  vim.keymap.set('n', '<leader>as', M.smart_ai_action, { desc = 'Smart AI Action' })
  vim.keymap.set('n', '<leader>ac', function() 
    vim.print(M.get_project_context()) 
  end, { desc = 'Show AI Context' })
  vim.keymap.set('n', '<leader>ap', M.select_provider, { desc = 'Select AI Provider' })
  
  -- Create provider switch commands
  vim.api.nvim_create_user_command('AISwitchProvider', function(opts)
    if opts.args and opts.args ~= "" then
      M.switch_provider(opts.args)
    else
      M.select_provider()
    end
  end, {
    nargs = '?',
    complete = function()
      return M.get_available_providers()
    end,
  })
  
  -- Initialize with AI mode off and set current provider
  M.ai_mode = false
  vim.g.ai_mode_active = false
  vim.g.ai_current_provider = M.providers.primary
end

return M