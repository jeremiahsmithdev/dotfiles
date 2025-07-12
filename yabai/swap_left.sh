# swap current window with the one in the space to the left
swap_left() {
  current_index=$(yabai -m query --spaces --space | jq '.index') # current space's index
  left_index=$(yabai -m query --spaces | jq ".[] | select(.index == $current_index - 1) | .index")

  win_a=$(yabai -m query --windows --space $current_index | jq '.[0].id') # first window id in current space
  win_b=$(yabai -m query --windows --space $left_index | jq '.[0].id') # first window id in left space

  yabai -m window "$win_a" --space $left_index # move current window to right space
  yabai -m window "$win_b" --space $current_index # move right window to current space

  yabai -m space --focus prev
}
