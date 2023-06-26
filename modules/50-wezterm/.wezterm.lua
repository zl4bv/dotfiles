local wezterm = require 'wezterm'
local config = {}

config.color_scheme = 'Night Owl (Gogh)'
config.font = wezterm.font 'Fira Code'
config.window_padding = {
  left = '2cell',
  right = '2cell',
  top = '1cell',
  bottom = '1cell',
}

config.hide_tab_bar_if_only_one_tab = true

return config
