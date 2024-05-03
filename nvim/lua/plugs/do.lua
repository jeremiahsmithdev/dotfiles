-- setup wherever you do that in you config (eg init.lua)
require("do").setup({
  -- default options
  winbar = false,
  message_timeout = 2000, -- how long notifications are shown
  kaomoji_mode = 0, -- 0 kaomoji everywhere, 1 skip kaomoji in doing
  doing_prefix = "Doing: ",
  store = {
    auto_create_file = false, -- automatically create a .do_tasks when calling :Do
    file_name = ".do_tasks",
  }
})

Bind('n', '<leader>de', ':DoEdit<CR>', 'noremap')
Bind('n', '<leader>ds', ':DoSave<CR>', 'noremap')
Bind('n', '<leader>dt', ':DoToggle<CR>', 'noremap')
Bind('n', '<leader>dd', ':Done!<CR>', 'noremap')

vim.cmd("cabbrev doing :DoEdit<CR>")

-- Usage
-- :Do add a line to the end of the list.
-- :Do! add a line to the front of list.
-- :Done! remove the first line from the list.
-- :DoEdit edit the list in a floating window.
-- :DoSave create .do_tasks file in cwd. Will auto-sync afterwards.
-- :DoToggle toggle the display. Use with caution!
