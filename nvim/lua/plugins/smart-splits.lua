-- Set to true to disable this plugin
local DISABLED = false
if DISABLED then return {} end

return {
  "mrjones2014/smart-splits.nvim",
  config = function()
    require("smart-splits").setup({
      at_edge = function(context)
        local dmap = {
          left = "prev",
          down = "south",
          up = "north",
          right = "next",
        }
        if context.mux.current_pane_at_edge(context.direction) then
          local ydirection = dmap[context.direction]
          local command = "yabai -m window --focus " .. ydirection .. " || $(yabai -m space --focus " .. ydirection .. ")"
          vim.fn.system(command)
        end
      end,
    })
  end,
}