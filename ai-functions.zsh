#!/usr/bin/env zsh
# AI-powered shell functions for enhanced workflow with Claude Code CLI

# AI-powered git commit messages
ai_commit() {
  local files=$(git diff --staged --name-only)
  if [[ -z "$files" ]]; then
    echo "No staged changes found"
    return 1
  fi

  echo "Generating AI commit message..."
  local message=$(echo "$files" | claude "Generate a concise, conventional commit message based on the following changed files. Assume typical changes for these file types. Return only the message, no explanation.")

  if [[ -n "$message" ]]; then
    echo "Suggested commit message: $message"
    read "?Use this message? (y/N): " response
    if [[ "$response" =~ ^[Yy]$ ]]; then
      git commit -m "$message"
      echo "✅ Committed with AI-generated message"
    else
      echo "Commit cancelled"
    fi
  else
    echo "❌ Failed to generate commit message"
  fi
}

# AI-powered command explanation
explain() {
  local cmd="$*"
  if [[ -z "$cmd" ]]; then
    cmd=$(fc -ln -1)  # Get last command
  fi
  echo "🤖 Explaining command: $cmd"
  claude "Explain this shell command concisely: $cmd"
}

# AI-powered error debugging
debug_error() {
  local error_output="$1"
  if [[ -z "$error_output" ]]; then
    error_output=$(fc -ln -1 2>&1)  # Get last command output
  fi
  echo "🔍 Debugging error..."
  claude "Debug this error and suggest solutions:\n\nError: $error_output\nContext: $(pwd)\nGit branch: $(git branch --show-current 2>/dev/null || echo 'not a git repo')"
}

# Context-aware file editing with AI
ai_edit() {
  local file="$1"
  if [[ -z "$file" ]]; then
    file=$(find . -type f \( -name "*.py" -o -name "*.js" -o -name "*.lua" -o -name "*.md" -o -name "*.rs" -o -name "*.go" \) | fzf --preview 'bat --style=numbers --color=always {}')
  fi
  
  if [[ -n "$file" && -f "$file" ]]; then
    echo "📝 Opening $file with AI context..."
    
    # Gather context
    local context=""
    context+="File: $file\n"
    context+="Git status: $(git status --porcelain "$file" 2>/dev/null || echo 'not tracked')\n"
    context+="Recent commits: $(git log --oneline -3 -- "$file" 2>/dev/null || echo 'no history')\n"
    context+="TODOs: $(grep -n 'TODO\|FIXME\|HACK' "$file" 2>/dev/null || echo 'none found')\n"
    
    # Open in nvim with AI context
    nvim "$file" -c "lua vim.defer_fn(function() vim.cmd('CodeCompanion Context: $context') end, 1000)"
  else
    echo "❌ File not found or not selected"
  fi
}

# Project-wide AI analysis
analyze_project() {
  echo "🔍 Analyzing project..."
  
  local analysis=""
  analysis+="📁 Project structure:\n$(tree -L 3 -I 'node_modules|.git|__pycache__|.venv' 2>/dev/null || find . -type d -maxdepth 3 | head -20)\n\n"
  analysis+="📊 Git summary:\n$(git log --oneline -10 2>/dev/null || echo 'not a git repo')\n\n"
  analysis+="📈 Recent changes:\n$(git diff --stat HEAD~5..HEAD 2>/dev/null || echo 'no recent changes')\n\n"
  analysis+="📝 TODO items:\n$(grep -r 'TODO\|FIXME\|HACK' . --include='*.py' --include='*.js' --include='*.lua' --include='*.md' 2>/dev/null | head -10 || echo 'no TODOs found')\n\n"
  analysis+="📦 Dependencies:\n$(find . -name 'package.json' -o -name 'requirements.txt' -o -name 'Cargo.toml' -o -name 'go.mod' 2>/dev/null || echo 'no package files found')\n"
  
  echo "$analysis" | claude "Analyze this project and provide insights, suggestions, and next steps"
}

# AI-powered file selection with context
ai_files() {
  local files
  files=$(find . -type f \( -name "*.py" -o -name "*.js" -o -name "*.lua" -o -name "*.md" -o -name "*.rs" -o -name "*.go" \) | 
    fzf --multi \
        --preview 'bat --style=numbers --color=always {} | head -50' \
        --preview-window 'right:60%' \
        --header 'Select files for AI context')
  
  if [[ -n "$files" ]]; then
    echo "📄 Analyzing selected files..."
    local content=""
    echo "$files" | while read -r file; do
      content+="=== $file ===\n"
      content+="$(cat "$file")\n\n"
    done
    echo "$content" | claude "Analyze these files and provide insights"
  fi
}

# AI-powered git branch analysis
ai_branches() {
  local branch
  branch=$(git branch -a 2>/dev/null | 
    fzf --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" $(echo {} | sed "s/.* //") 2>/dev/null | head -20' \
        --header 'Select branch for AI analysis')
  
  if [[ -n "$branch" ]]; then
    local branch_name=$(echo "$branch" | sed 's/.* //' | sed 's/^[* ]*//')
    echo "🌿 Analyzing branch: $branch_name"
    
    local analysis=""
    analysis+="Branch: $branch_name\n"
    analysis+="Commits: $(git log --oneline "$branch_name" 2>/dev/null | head -10)\n"
    analysis+="Diff from main: $(git diff main.."$branch_name" --stat 2>/dev/null || git diff master.."$branch_name" --stat 2>/dev/null || echo 'no diff available')\n"
    
    echo "$analysis" | claude "Analyze this git branch and provide insights"
  fi
}

# Smart AI action based on current directory context
ai_smart() {
  local context=""
  context+="📍 Current directory: $(pwd)\n"
  context+="📁 Files: $(ls -la | head -10)\n"
  
  if git rev-parse --git-dir >/dev/null 2>&1; then
    context+="🌿 Git branch: $(git branch --show-current)\n"
    context+="📊 Git status: $(git status --porcelain | head -5)\n"
  fi
  
  context+="💻 Last command: $(fc -ln -1)\n"
  
  echo "$context" | claude "Based on this context, suggest the most helpful next action I should take"
}

# AI-powered code review for staged changes
ai_review() {
  local diff=$(git diff --staged)
  if [[ -z "$diff" ]]; then
    echo "No staged changes to review"
    return 1
  fi
  
  echo "🔍 Reviewing staged changes..."
  echo "$diff" | claude "Review this code diff and provide feedback on:\n1. Code quality\n2. Potential issues\n3. Suggestions for improvement\n4. Security considerations"
}

# AI-powered test generation
ai_test() {
  local file="$1"
  if [[ -z "$file" ]]; then
    file=$(find . -type f \( -name "*.py" -o -name "*.js" -o -name "*.lua" -o -name "*.rs" -o -name "*.go" \) | fzf --preview 'bat --style=numbers --color=always {}')
  fi
  
  if [[ -n "$file" && -f "$file" ]]; then
    echo "🧪 Generating tests for $file..."
    local content=$(cat "$file")
    echo "$content" | claude "Generate comprehensive unit tests for this code. Include edge cases and error handling."
  fi
}

# AI-powered documentation generation
ai_docs() {
  local file="$1"
  if [[ -z "$file" ]]; then
    file=$(find . -type f \( -name "*.py" -o -name "*.js" -o -name "*.lua" -o -name "*.rs" -o -name "*.go" \) | fzf --preview 'bat --style=numbers --color=always {}')
  fi
  
  if [[ -n "$file" && -f "$file" ]]; then
    echo "📚 Generating documentation for $file..."
    local content=$(cat "$file")
    echo "$content" | claude "Generate comprehensive documentation for this code including:\n1. Overview\n2. Function/method descriptions\n3. Parameters and return values\n4. Usage examples"
  fi
}

# Quick AI chat
ai_chat() {
  local message="$*"
  if [[ -z "$message" ]]; then
    echo "💬 Starting AI chat session..."
    claude
  else
    claude "$message"
  fi
}

# AI-powered refactoring suggestions
ai_refactor() {
  local file="$1"
  if [[ -z "$file" ]]; then
    file=$(find . -type f \( -name "*.py" -o -name "*.js" -o -name "*.lua" -o -name "*.rs" -o -name "*.go" \) | fzf --preview 'bat --style=numbers --color=always {}')
  fi
  
  if [[ -n "$file" && -f "$file" ]]; then
    echo "🔧 Analyzing $file for refactoring opportunities..."
    local content=$(cat "$file")
    echo "$content" | claude "Analyze this code and suggest refactoring improvements for:\n1. Code structure\n2. Performance\n3. Readability\n4. Maintainability\n5. Best practices"
  fi
}

# Functions are automatically available in zsh without explicit export