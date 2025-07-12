# swap current window with the one in the space to the right
swap_right() {
  current_index=$(yabai -m query --spaces --space | jq '.index') # current space's index
  right_index=$(yabai -m query --spaces | jq "[.[] | select(.index > $current_index)] | first | .index") # next space's index (right of current)

  win_a=$(yabai -m query --windows --space $current_index | jq '.[0].id') # first window id in current space
  win_b=$(yabai -m query --windows --space $right_index | jq '.[0].id') # first window id in right space

  yabai -m window "$win_a" --space $right_index # move current window to right space
  yabai -m window "$win_b" --space $current_index # move right window to current space

  yabai -m space --focus next
}
