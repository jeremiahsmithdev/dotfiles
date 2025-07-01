-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  group = highlight_group,
  callback = function()
    vim.highlight.on_yank()
  end,
  pattern = '*',
})

vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = vim.fn.expand("~/TODO.md"),
  callback = function()
    vim.keymap.set('n', 'q', ':q<CR>', { buffer = true, silent = true })
  end,
})



-- Autocmd group for TODO.md
local todo_group = vim.api.nvim_create_augroup("TodoMd", { clear = true })

-- 1. Auto-insert '- [ ] ' on new lines in insert mode
vim.api.nvim_create_autocmd("FileType", {
  group = todo_group,
  pattern = "markdown",
  callback = function()
    if vim.fn.expand("%:t") == "TODO.md" then
      vim.keymap.set("i", "<CR>", function()
        local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
        local prev_line = vim.api.nvim_buf_get_lines(0, row - 1, row, false)[1] or ""
        local prefix = "- [ ] "
        if prev_line:match("^%- %[[ xX]%] ") then
          return "\n" .. prefix
        else
          return "\n"
        end
      end, { buffer = true, expr = true })
    end
  end,
})

-- 2. Toggle task completion with <CR> in normal mode, and handle o/O
vim.api.nvim_create_autocmd("BufReadPost", {
  group = todo_group,
  pattern = "TODO.md",
  callback = function(args)
    -- Toggle task with <CR>
    vim.keymap.set("n", "<CR>", function()
      local line = vim.api.nvim_get_current_line()
      if line:match("^%- %[ %] ") then
        local new_line = line:gsub("^%- %[ %] ", "- [x] ")
        vim.schedule(function()
          vim.api.nvim_set_current_line(new_line)
        end)
        return ""
      elseif line:match("^%- %[[xX]%] ") then
        local new_line = line:gsub("^%- %[[xX]%] ", "- [ ] ")
        vim.schedule(function()
          vim.api.nvim_set_current_line(new_line)
        end)
        return ""
      else
        return vim.api.nvim_replace_termcodes("<CR>", true, false, true)
      end
    end, { noremap = true, buffer = args.buf, expr = true, silent = true })

    -- o Mapping
    vim.keymap.set("n", "o", function()
      local line = vim.api.nvim_get_current_line()
      if line:match("^%- %[[ xX]%] ") then
        local row = vim.api.nvim_win_get_cursor(0)[1]
        vim.schedule(function()
          vim.api.nvim_buf_set_lines(0, row, row, false, { "- [ ] " })
          vim.api.nvim_win_set_cursor(0, { row + 1, 1 }) -- move to start of new line
          vim.api.nvim_feedkeys('A', 'n', false)
        end)
        return ""
      else
        return "o"
      end
    end, { buffer = args.buf, expr = true })

    -- O Mapping
    vim.keymap.set("n", "O", function()
      local line = vim.api.nvim_get_current_line()
      if line:match("^%- %[[ xX]%] ") then
        local row = vim.api.nvim_win_get_cursor(0)[1]
        vim.schedule(function()
          vim.api.nvim_buf_set_lines(0, row - 1, row - 1, false, { "- [ ] " })
          vim.api.nvim_win_set_cursor(0, { row, 1 }) -- move to start of new line
          vim.api.nvim_feedkeys('A', 'n', false)
        end)
        return ""
      else
        return "O"
      end
    end, { buffer = args.buf, expr = true })
  end,
})
