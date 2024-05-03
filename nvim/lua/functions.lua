
-- notification to go to bed
function check_condition_and_notify()
  -- Replace the following line with your actual condition check
  -- local condition_met = true -- This is just a placeholder condition
  

  -- variable to store the time


  -- local hour = os.date("t").hour
  local current_time = os.date("*t")
  local time_variable = current_time.hour * 60 + current_time.min
  if time_variable < 300 and time_variable > 1320 then
    vim.notify("Go to bed!!!", vim.log.levels.WARN)
  end
end

-- Set the interval in milliseconds (e.g., 60000ms = 1 minute)
-- local interval = 60000
local interval = 6000

-- Create a timer that calls the function at the specified interval
local timer = vim.loop.new_timer()
timer:start(0, interval, vim.schedule_wrap(check_condition_and_notify))

-- 
function create_command(input, output)
  vim.api.nvim_create_user_command(input, output, {})
end
