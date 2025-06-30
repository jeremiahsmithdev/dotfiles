-- AI Mode Management and Smart Switching
local M = {}

-- Import unified AI config
local ai_unified = require('config.ai-unified')

-- Mode definitions
M.modes = {
  MANUAL = "manual",
  AI_ASSIST = "ai_assist", 
  AI_PAIR = "ai_pair",
  AI_AUTONOMOUS = "ai_autonomous"
}

M.current_mode = M.modes.MANUAL

-- Mode configurations
M.mode_configs = {
  [M.modes.MANUAL] = {
    name = "Manual",
    icon = "✋",
    description = "Full manual control",
    ai_suggestions = false,
    auto_complete = false,
    context_aware = false,
  },
  [M.modes.AI_ASSIST] = {
    name = "AI Assist",
    icon = "🤝",
    description = "AI suggestions on demand",
    ai_suggestions = true,
    auto_complete = false,
    context_aware = true,
  },
  [M.modes.AI_PAIR] = {
    name = "AI Pair",
    icon = "👥",
    description = "Active AI pair programming",
    ai_suggestions = true,
    auto_complete = true,
    context_aware = true,
  },
  [M.modes.AI_AUTONOMOUS] = {
    name = "AI Autonomous",
    icon = "🤖",
    description = "AI-driven development",
    ai_suggestions = true,
    auto_complete = true,
    context_aware = true,
  }
}

-- Switch to specific mode
function M.switch_mode(mode)
  if not M.mode_configs[mode] then
    vim.notify("Invalid AI mode: " .. mode, vim.log.levels.ERROR)
    return
  end
  
  local old_mode = M.current_mode
  M.current_mode = mode
  local config = M.mode_configs[mode]
  
  -- Update global state
  vim.g.ai_mode_current = mode
  vim.g.ai_mode_config = config
  
  -- Apply mode-specific configurations
  M.apply_mode_config(config)
  
  -- Notify user
  vim.notify(
    string.format("%s %s Mode Activated", config.icon, config.name),
    vim.log.levels.INFO,
    { title = "AI Workflow" }
  )
  
  -- Trigger mode change event
  vim.api.nvim_exec_autocmds("User", { pattern = "AIModeChanged", data = { old = old_mode, new = mode } })
end

-- Cycle through modes
function M.cycle_mode()
  local modes_order = { M.modes.MANUAL, M.modes.AI_ASSIST, M.modes.AI_PAIR, M.modes.AI_AUTONOMOUS }
  local current_index = 1
  
  for i, mode in ipairs(modes_order) do
    if mode == M.current_mode then
      current_index = i
      break
    end
  end
  
  local next_index = (current_index % #modes_order) + 1
  M.switch_mode(modes_order[next_index])
end

-- Apply mode-specific configuration
function M.apply_mode_config(config)
  -- Clear existing AI keymaps
  M.clear_ai_keymaps()
  
  if config.ai_suggestions then
    M.setup_ai_keymaps()
  end
  
  if config.auto_complete then
    M.enable_auto_complete()
  else
    M.disable_auto_complete()
  end
  
  if config.context_aware then
    M.enable_context_awareness()
  else
    M.disable_context_awareness()
  end
end

-- Set up AI-specific keymaps based on mode
function M.setup_ai_keymaps()
  local opts = { buffer = false, silent = true }
  
  if M.current_mode == M.modes.AI_ASSIST then
    -- On-demand AI assistance
    vim.keymap.set('n', '<leader><CR>', function() ai_unified.smart_ai_action() end,
      vim.tbl_extend('force', opts, { desc = 'AI Assist Action' }))
    vim.keymap.set('v', '<leader><CR>', function() ai_unified.smart_ai_action() end,
      vim.tbl_extend('force', opts, { desc = 'AI Assist Action (Visual)' }))
      
  elseif M.current_mode == M.modes.AI_PAIR then
    -- Active pair programming
    vim.keymap.set('n', '<CR>', function() ai_unified.smart_ai_action() end,
      vim.tbl_extend('force', opts, { desc = 'AI Pair Action' }))
    vim.keymap.set('v', '<CR>', function() ai_unified.smart_ai_action() end,
      vim.tbl_extend('force', opts, { desc = 'AI Pair Action (Visual)' }))
    vim.keymap.set('n', '<Tab>', function() ai_unified.ai_suggest() end,
      vim.tbl_extend('force', opts, { desc = 'AI Suggest' }))
    vim.keymap.set('n', '?', function() ai_unified.explain_current() end,
      vim.tbl_extend('force', opts, { desc = 'AI Explain' }))
      
  elseif M.current_mode == M.modes.AI_AUTONOMOUS then
    -- Autonomous AI development
    vim.keymap.set('n', '<CR>', function() M.autonomous_action() end,
      vim.tbl_extend('force', opts, { desc = 'AI Autonomous Action' }))
    vim.keymap.set('n', '<Space>', function() M.autonomous_continue() end,
      vim.tbl_extend('force', opts, { desc = 'AI Continue' }))
  end
end

-- Clear AI-specific keymaps
function M.clear_ai_keymaps()
  local keymaps_to_remove = { '<CR>', '<Tab>', '?', '<leader><CR>', '<Space>' }
  
  for _, key in ipairs(keymaps_to_remove) do
    pcall(vim.keymap.del, 'n', key, { buffer = false })
    pcall(vim.keymap.del, 'v', key, { buffer = false })
  end
end

-- Enable auto-completion features
function M.enable_auto_complete()
  -- Enable Copilot suggestions
  if pcall(require, 'copilot') then
    vim.cmd('Copilot enable')
  end
  
  -- Enable Codeium
  if pcall(require, 'codeium') then
    vim.g.codeium_enabled = true
  end
  
  -- Configure nvim-cmp for aggressive completion
  local cmp = require('cmp')
  if cmp then
    cmp.setup({
      completion = {
        autocomplete = { 'TextChanged' },
        completeopt = 'menu,menuone,noselect',
      },
    })
  end
end

-- Disable auto-completion features
function M.disable_auto_complete()
  -- Disable Copilot suggestions
  if pcall(require, 'copilot') then
    vim.cmd('Copilot disable')
  end
  
  -- Disable Codeium
  if pcall(require, 'codeium') then
    vim.g.codeium_enabled = false
  end
  
  -- Configure nvim-cmp for manual completion
  local cmp = require('cmp')
  if cmp then
    cmp.setup({
      completion = {
        autocomplete = false,
        completeopt = 'menu,menuone,noselect',
      },
    })
  end
end

-- Enable context awareness
function M.enable_context_awareness()
  -- Set up autocommands for context tracking
  vim.api.nvim_create_augroup("AIContextAware", { clear = true })
  
  -- Track cursor movements for context
  vim.api.nvim_create_autocmd("CursorMoved", {
    group = "AIContextAware",
    callback = function()
      M.update_context_on_cursor_move()
    end,
  })
  
  -- Track file changes
  vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost" }, {
    group = "AIContextAware",
    callback = function()
      M.update_file_context()
    end,
  })
  
  -- Track LSP diagnostics
  vim.api.nvim_create_autocmd("DiagnosticChanged", {
    group = "AIContextAware",
    callback = function()
      M.update_diagnostic_context()
    end,
  })
end

-- Disable context awareness
function M.disable_context_awareness()
  pcall(vim.api.nvim_del_augroup_by_name, "AIContextAware")
end

-- Context update functions
function M.update_context_on_cursor_move()
  if M.current_mode == M.modes.AI_AUTONOMOUS then
    -- In autonomous mode, check if we should suggest actions
    local line = vim.api.nvim_get_current_line()
    if line:match("TODO") or line:match("FIXME") then
      vim.defer_fn(function()
        vim.notify("AI: Found TODO item. Press <CR> for suggestions", vim.log.levels.INFO)
      end, 1000)
    end
  end
end

function M.update_file_context()
  -- Update project context when files change
  if M.mode_configs[M.current_mode].context_aware then
    ai_unified.current_context = ai_unified.get_project_context()
  end
end

function M.update_diagnostic_context()
  -- React to new diagnostics in AI modes
  if M.current_mode == M.modes.AI_PAIR or M.current_mode == M.modes.AI_AUTONOMOUS then
    local diagnostics = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
    if #diagnostics > 0 then
      vim.defer_fn(function()
        vim.notify("AI: Errors detected. Press ? for help", vim.log.levels.WARN)
      end, 2000)
    end
  end
end

-- Autonomous mode actions
function M.autonomous_action()
  local context = ai_unified.get_project_context()
  local line = vim.api.nvim_get_current_line()
  
  -- Analyze current situation and take appropriate action
  if line:match("TODO") or line:match("FIXME") then
    vim.cmd('Gen Enhance_Code')
  elseif #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR }) > 0 then
    vim.cmd('Gen Fix_Code')
  elseif line:trim() == "" then
    vim.cmd('Gen Generate_Code')
  else
    vim.cmd('CodeCompanionActions')
  end
end

function M.autonomous_continue()
  -- Continue autonomous development
  vim.cmd('CodeCompanion Continue with the current task')
end

-- Get current mode info
function M.get_current_mode()
  return {
    mode = M.current_mode,
    config = M.mode_configs[M.current_mode],
  }
end

-- Mode-specific status for statusline
function M.get_statusline_component()
  local config = M.mode_configs[M.current_mode]
  return string.format("%s %s", config.icon, config.name)
end

-- Initialize AI modes
function M.setup()
  -- Set up global keymaps
  vim.keymap.set('n', '<leader>am', M.cycle_mode, { desc = 'Cycle AI Mode' })
  vim.keymap.set('n', '<leader>a1', function() M.switch_mode(M.modes.MANUAL) end, { desc = 'Manual Mode' })
  vim.keymap.set('n', '<leader>a2', function() M.switch_mode(M.modes.AI_ASSIST) end, { desc = 'AI Assist Mode' })
  vim.keymap.set('n', '<leader>a3', function() M.switch_mode(M.modes.AI_PAIR) end, { desc = 'AI Pair Mode' })
  vim.keymap.set('n', '<leader>a4', function() M.switch_mode(M.modes.AI_AUTONOMOUS) end, { desc = 'AI Autonomous Mode' })
  
  -- Set up mode info command
  vim.api.nvim_create_user_command('AIModeInfo', function()
    local info = M.get_current_mode()
    vim.notify(
      string.format("Current Mode: %s %s\n%s", 
        info.config.icon, 
        info.config.name, 
        info.config.description),
      vim.log.levels.INFO,
      { title = "AI Mode Info" }
    )
  end, {})
  
  -- Initialize in manual mode
  M.switch_mode(M.modes.MANUAL)
end

return M