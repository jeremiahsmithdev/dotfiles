return {
  "nvim-lua/plenary.nvim",
  config = function()
    vim.api.nvim_create_user_command("DiffAll", function()
      require("custom.gitdiff").open_git_diffs()
    end, {})
  end,
}