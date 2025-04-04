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
          -- command = "yabai -m window --focus west || $(yabai -m display --focus west) || $(yabai -m space --focus prev)"

          -- if ydirection == "west" or ydirection == "east" then
          --   command = command .. " || $(yabai -m space --focus " .. ydirection .. ")"
          -- end

          vim.fn.system(command)
        end
      end,
    })
