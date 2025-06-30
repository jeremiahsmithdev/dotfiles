-- AI Shell Integration for Neovim
local M = {}

-- Shell command execution with AI integration
function M.execute_with_ai_context(cmd, opts)
  opts = opts or {}
  local context = require('config.ai-unified').get_project_context()
  
  -- Add context to command if requested
  if opts.with_context then
    local context_str = string.format(
      "# Project Context\n# File: %s\n# Branch: %s\n# Root: %s\n\n",
      context.files.current_relative,
      context.git.branch,
      context.files.project_root
    )
    cmd = context_str .. cmd
  end
  
  -- Execute command
  local result = vim.fn.system(cmd)
  
  -- If AI analysis requested, send result to AI
  if opts.ai_analyze then
    local analysis_prompt = string.format(
      "Analyze this command output and provide insights:\nCommand: %s\nOutput:\n%s",
      cmd, result
    )
    vim.cmd('CodeCompanion ' .. vim.fn.shellescape(analysis_prompt))
  end
  
  return result
end

-- AI-powered git commit message generation
function M.ai_commit()
  local diff = vim.fn.system("git diff --staged")
  if diff == "" then
    vim.notify("No staged changes found", vim.log.levels.WARN)
    return
  end
  
  -- Get AI-generated commit message
  local prompt = "Generate a concise, conventional commit message for these changes. Return only the message:\n\n" .. diff
  
  -- Use a temporary file for the AI response
  local temp_file = vim.fn.tempname()
  vim.fn.writefile({ prompt }, temp_file)
  
  -- Call Claude CLI (adjust path as needed)
  local claude_cmd = string.format("claude < %s", temp_file)
  local message = vim.fn.system(claude_cmd):gsub("\n$", "")
  
  -- Clean up temp file
  vim.fn.delete(temp_file)
  
  if message ~= "" then
    -- Show the message and ask for confirmation
    local choice = vim.fn.confirm(
      string.format("Suggested commit message:\n\n%s\n\nUse this message?", message),
      "&Yes\n&No\n&Edit",
      1
    )
    
    if choice == 1 then
      -- Use the message as-is
      vim.fn.system(string.format("git commit -m %s", vim.fn.shellescape(message)))
      vim.notify("Committed with AI-generated message", vim.log.levels.INFO)
    elseif choice == 3 then
      -- Edit the message
      vim.ui.input({ prompt = "Edit commit message: ", default = message }, function(edited_message)
        if edited_message and edited_message ~= "" then
          vim.fn.system(string.format("git commit -m %s", vim.fn.shellescape(edited_message)))
          vim.notify("Committed with edited message", vim.log.levels.INFO)
        end
      end)
    end
  else
    vim.notify("Failed to generate commit message", vim.log.levels.ERROR)
  end
end

-- AI-powered command explanation
function M.explain_command(cmd)
  if not cmd or cmd == "" then
    -- Get the last command from shell history
    cmd = vim.fn.system("fc -ln -1"):gsub("^%s+", ""):gsub("%s+$", "")
  end
  
  local prompt = string.format("Explain this shell command in detail: %s", cmd)
  vim.cmd('CodeCompanion ' .. vim.fn.shellescape(prompt))
end

-- AI-powered error debugging
function M.debug_error(error_output)
  if not error_output or error_output == "" then
    -- Try to get error from last command
    error_output = vim.fn.system("fc -ln -1 2>&1")
  end
  
  local prompt = string.format(
    "Debug this error and suggest solutions:\n\nError output:\n%s\n\nContext:\n- Working directory: %s\n- Git branch: %s",
    error_output,
    vim.fn.getcwd(),
    vim.fn.system("git branch --show-current 2>/dev/null"):gsub("\n", "")
  )
  
  vim.cmd('CodeCompanion ' .. vim.fn.shellescape(prompt))
end

-- Context-aware file editing with AI
function M.ai_edit_file(file)
  if not file or file == "" then
    -- Use fzf to select a file
    local fzf_cmd = "find . -type f -name '*.lua' -o -name '*.py' -o -name '*.js' -o -name '*.md' | fzf --preview 'bat --style=numbers --color=always {}'"
    file = vim.fn.system(fzf_cmd):gsub("\n$", "")
  end
  
  if file == "" then
    return
  end
  
  -- Gather context about the file
  local context = {}
  table.insert(context, "File: " .. file)
  
  -- Git context for the file
  local git_status = vim.fn.system(string.format("git status --porcelain %s 2>/dev/null", file))
  if git_status ~= "" then
    table.insert(context, "Git status: " .. git_status:gsub("\n$", ""))
  end
  
  local git_log = vim.fn.system(string.format("git log --oneline -5 -- %s 2>/dev/null", file))
  if git_log ~= "" then
    table.insert(context, "Recent commits:")
    table.insert(context, git_log)
  end
  
  -- LSP diagnostics if available
  local diagnostics_cmd = string.format("grep -n 'TODO\\|FIXME\\|HACK' %s 2>/dev/null || true", file)
  local todos = vim.fn.system(diagnostics_cmd)
  if todos ~= "" then
    table.insert(context, "TODOs/FIXMEs:")
    table.insert(context, todos)
  end
  
  -- Open file in Neovim with context
  vim.cmd(string.format("edit %s", file))
  
  -- Add context to AI
  local context_str = table.concat(context, "\n")
  vim.defer_fn(function()
    vim.cmd('CodeCompanion ' .. vim.fn.shellescape("I'm working on this file. Here's the context:\n\n" .. context_str))
  end, 1000)
end

-- Project-wide AI analysis
function M.analyze_project()
  local analysis = {}
  
  -- Project structure
  local tree_output = vim.fn.system("tree -L 3 -I 'node_modules|.git|__pycache__|.venv' 2>/dev/null || find . -type d -maxdepth 3 | head -20")
  table.insert(analysis, "Project structure:")
  table.insert(analysis, tree_output)
  table.insert(analysis, "")
  
  -- Git summary
  local git_summary = vim.fn.system("git log --oneline -10 2>/dev/null")
  if git_summary ~= "" then
    table.insert(analysis, "Recent commits:")
    table.insert(analysis, git_summary)
    table.insert(analysis, "")
  end
  
  -- Recent changes
  local git_diff_stat = vim.fn.system("git diff --stat HEAD~5..HEAD 2>/dev/null")
  if git_diff_stat ~= "" then
    table.insert(analysis, "Recent changes:")
    table.insert(analysis, git_diff_stat)
    table.insert(analysis, "")
  end
  
  -- TODO items
  local todos = vim.fn.system("grep -r 'TODO\\|FIXME\\|HACK' . --include='*.py' --include='*.js' --include='*.lua' --include='*.md' 2>/dev/null | head -10")
  if todos ~= "" then
    table.insert(analysis, "TODO items:")
    table.insert(analysis, todos)
    table.insert(analysis, "")
  end
  
  -- Package files
  local package_files = vim.fn.system("find . -name 'package.json' -o -name 'requirements.txt' -o -name 'Cargo.toml' -o -name 'go.mod' 2>/dev/null")
  if package_files ~= "" then
    table.insert(analysis, "Package files found:")
    table.insert(analysis, package_files)
  end
  
  local analysis_str = table.concat(analysis, "\n")
  local prompt = "Analyze this project and provide insights, suggestions, and next steps:\n\n" .. analysis_str
  
  vim.cmd('CodeCompanion ' .. vim.fn.shellescape(prompt))
end

-- FZF integration for AI context
function M.fzf_ai_files()
  local fzf_cmd = [[
    find . -type f \( -name "*.py" -o -name "*.js" -o -name "*.lua" -o -name "*.md" -o -name "*.rs" -o -name "*.go" \) | 
    fzf --multi \
        --preview 'bat --style=numbers --color=always {} | head -50' \
        --preview-window 'right:60%' \
        --header 'Select files for AI context' \
        --bind 'enter:become(echo {+})'
  ]]
  
  local selected_files = vim.fn.system(fzf_cmd):gsub("\n$", "")
  
  if selected_files ~= "" then
    local files = vim.split(selected_files, "\n")
    local content = {}
    
    for _, file in ipairs(files) do
      table.insert(content, "=== " .. file .. " ===")
      local file_content = vim.fn.readfile(file)
      for _, line in ipairs(file_content) do
        table.insert(content, line)
      end
      table.insert(content, "")
    end
    
    local content_str = table.concat(content, "\n")
    local prompt = "Analyze these files and provide insights:\n\n" .. content_str
    
    vim.cmd('CodeCompanion ' .. vim.fn.shellescape(prompt))
  end
end

-- AI-powered git branch analysis
function M.fzf_ai_branches()
  local fzf_cmd = [[
    git branch -a | 
    fzf --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" $(echo {} | sed "s/.* //") | head -20' \
        --header 'Select branch for AI analysis'
  ]]
  
  local selected_branch = vim.fn.system(fzf_cmd):gsub("\n$", ""):gsub("^%s*", ""):gsub("%s*$", "")
  
  if selected_branch ~= "" then
    -- Remove leading asterisk and whitespace
    selected_branch = selected_branch:gsub("^%*%s*", ""):gsub("^%s*", "")
    
    local analysis = {}
    table.insert(analysis, "Branch: " .. selected_branch)
    
    local commits = vim.fn.system(string.format("git log --oneline %s | head -10", selected_branch))
    table.insert(analysis, "Recent commits:")
    table.insert(analysis, commits)
    
    local diff_stat = vim.fn.system(string.format("git diff main..%s --stat 2>/dev/null || git diff master..%s --stat 2>/dev/null", selected_branch, selected_branch))
    if diff_stat ~= "" then
      table.insert(analysis, "Diff from main:")
      table.insert(analysis, diff_stat)
    end
    
    local analysis_str = table.concat(analysis, "\n")
    local prompt = "Analyze this git branch and provide insights:\n\n" .. analysis_str
    
    vim.cmd('CodeCompanion ' .. vim.fn.shellescape(prompt))
  end
end

-- Terminal integration functions
function M.setup_terminal_integration()
  -- Create terminal commands for AI integration
  vim.api.nvim_create_user_command('AICommit', M.ai_commit, {})
  vim.api.nvim_create_user_command('AIExplain', function(opts)
    M.explain_command(opts.args)
  end, { nargs = '?' })
  vim.api.nvim_create_user_command('AIDebug', function(opts)
    M.debug_error(opts.args)
  end, { nargs = '?' })
  vim.api.nvim_create_user_command('AIEdit', function(opts)
    M.ai_edit_file(opts.args)
  end, { nargs = '?' })
  vim.api.nvim_create_user_command('AIAnalyze', M.analyze_project, {})
  vim.api.nvim_create_user_command('AIFiles', M.fzf_ai_files, {})
  vim.api.nvim_create_user_command('AIBranches', M.fzf_ai_branches, {})
end

-- Set up keybindings
function M.setup_keybindings()
  local opts = { silent = true }
  
  -- AI shell integration
  vim.keymap.set('n', '<leader>gc', M.ai_commit, vim.tbl_extend('force', opts, { desc = 'AI Git Commit' }))
  vim.keymap.set('n', '<leader>ge', function() M.explain_command() end, vim.tbl_extend('force', opts, { desc = 'AI Explain Command' }))
  vim.keymap.set('n', '<leader>gd', function() M.debug_error() end, vim.tbl_extend('force', opts, { desc = 'AI Debug Error' }))
  vim.keymap.set('n', '<leader>gf', function() M.ai_edit_file() end, vim.tbl_extend('force', opts, { desc = 'AI Edit File' }))
  vim.keymap.set('n', '<leader>ga', M.analyze_project, vim.tbl_extend('force', opts, { desc = 'AI Analyze Project' }))
  
  -- FZF AI integration
  vim.keymap.set('n', '<leader>mf', M.fzf_ai_files, vim.tbl_extend('force', opts, { desc = 'AI File Analysis' }))
  vim.keymap.set('n', '<leader>mb', M.fzf_ai_branches, vim.tbl_extend('force', opts, { desc = 'AI Branch Analysis' }))
end

-- Initialize shell integration
function M.setup()
  M.setup_terminal_integration()
  M.setup_keybindings()
  
  -- Set up autocommands for shell integration
  vim.api.nvim_create_augroup("AIShellIntegration", { clear = true })
  
  -- Auto-suggest AI commit when staging files
  vim.api.nvim_create_autocmd("User", {
    group = "AIShellIntegration",
    pattern = "GitStagedFiles",
    callback = function()
      vim.defer_fn(function()
        vim.notify("Files staged. Use :AICommit for AI-generated commit message", vim.log.levels.INFO)
      end, 1000)
    end,
  })
end

return M