-- Set to true to disable this plugin
local DISABLED = false
if DISABLED then return {} end

return {
  "mfussenegger/nvim-dap",
  config = function()
    local dap = require('dap')

    dap.adapters.php = {
      type = 'executable',
      command = 'node',
      args = { '/Users/admin/dotfiles/dap/vscode-php-debug/out/phpDebug.js' }
    }

    dap.configurations.php = {
      {
        type = 'php',
        request = 'launch',
        name = 'Listen for Xdebug',
        port = 9003
      }
    }
  end,
}