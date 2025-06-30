return {

  -- Open with tmux
  default_prog = {
    "/opt/homebrew/bin/zsh",
    "--login",  "-c",
    "tmux attach || tmux",
  },

  hide_tab_bar_if_only_one_tab = true,

  color_scheme = "gruvbox_material_dark_hard",
  color_schemes = {
    ["gruvbox_material_dark_hard"] = {
      foreground = "#D4BE98",
      background = "#1D2021",
      cursor_bg = "#D4BE98",
      cursor_border = "#D4BE98",
      cursor_fg = "#1D2021",
      selection_bg = "#D4BE98",
      selection_fg = "#3C3836",
      ansi = {
        "#1d2021", "#ea6962", "#a9b665", "#d8a657",
        "#7daea3", "#d3869b", "#89b482", "#d4be98"
      },
      brights = {
        "#eddeb5", "#ea6962", "#a9b665", "#d8a657",
        "#7daea3", "#d3869b", "#89b482", "#d4be98"
      },
      -- Set transparency: background Opacity (0.0 is fully transparent, 1.0 is opaque)
      background_opacity = 0.85,
    },
  },
}

