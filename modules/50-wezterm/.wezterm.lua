local wezterm = require 'wezterm'
local config = {}

config.color_scheme = 'Night Owl (Gogh)'
config.font = wezterm.font 'Fira Code'

function scheme_for_appearance(appearance)
  if appearance:find("Dark") then
    return "Night Owl (Gogh)"
  else
    return "Night Owlish Light"
  end
end

wezterm.on("window-config-reloaded", function(window, pane)
  local overrides = window:get_config_overrides() or {}
  local appearance = window:get_appearance()
  local scheme = scheme_for_appearance(appearance)
  if overrides.color_scheme ~= scheme then
    overrides.color_scheme = scheme
    window:set_config_overrides(overrides)
  end
end)

return config
