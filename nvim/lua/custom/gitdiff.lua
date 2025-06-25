local M = {}

function M.open_git_diffs()
  local handle = io.popen("git diff --name-only")
  if not handle then
    vim.notify("Failed to run git diff", vim.log.levels.ERROR)
    return
  end

  local output = handle:read("*a")
  handle:close()

  local files = {}
  for file in string.gmatch(output, "[^\r\n]+") do
    table.insert(files, file)
  end

  if #files == 0 then
    vim.notify("No changes detected", vim.log.levels.INFO)
    return
  end

  for i, file in ipairs(files) do
    if i > 1 then
      vim.cmd("tabnew")
    end
    vim.cmd("edit " .. file)
    vim.cmd("vert diffsplit | Git show HEAD:" .. file)
  end
end

return M
