require("codecompanion").setup({
 display = {
chat = {
      window = {
        position = "right",  -- or "left", "top", "bottom"
      },
    },
    diff = {
      enabled = true,
      close_chat_at = 240, -- Close an open chat buffer if the total columns of your display are less than...
      layout = "vertical", -- vertical|horizontal split for default provider
      opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
      provider = "default", -- default|mini_diff
    },
  },
  strategies = {
    chat = {
      adapter = "openai",
    },
    inline = {
      adapter = "openai",
    },
  },
  extensions = {
    mcphub = {
      callback = "mcphub.extensions.codecompanion",
      opts = {
        make_vars = true,
        make_slash_commands = true,
        show_result_in_chat = true
      }
    }
  },

  -- toggle cc chat with q (unmap default Stop Request)
vim.api.nvim_create_autocmd("FileType", {
  pattern = "codecompanion",
  callback = function()
    vim.defer_fn(function()
      -- Remove all q mappings in this buffer
      pcall(vim.api.nvim_buf_del_keymap, 0, "n", "q")
      -- Now set your mapping for q
      vim.keymap.set("n", "q", function()
        -- Replace with your actual toggle function/logic
        vim.cmd("lua require('codecompanion').toggle()")
      end, { buffer = true, remap = false })
    end, 100) -- 100ms delay to ensure plugin mappings are set first
  end,
}),

  -- toggle diff buffer with q
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = "[CodeCompanion]*", -- Matches buffer names starting with [CodeCompanion]
--   callback = function()
--     vim.defer_fn(function()
--       -- Map 'q' to close the buffer (or your desired action)
--       vim.keymap.set('n', 'q', ':q<CR>', { buffer = true, desc = 'Close buffer' })
--     end, 100)
--   end,
-- })
})
