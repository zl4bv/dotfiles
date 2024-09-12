-- zl4bv's wezterm configuration
--
-- with inspiration from:
-- https://codeberg.org/aral/.config/src/branch/main/wezterm.lua
local wezterm = require 'wezterm'
local config = {}

function colors_for_appearance(appearance)
  local colors = {}

  if appearance:find 'Dark' then
    -- Dark Mode. Based on Night Owl.
    colors.tab_bar = {
      active_tab = {
        bg_color = '#0b2942',
        fg_color = '#d2dee7'
      },

      inactive_tab = {
        bg_color = '#01111d',
        fg_color = '#5f7e97'
      },
      inactive_tab_edge = '#272b3b',
      inactive_tab_hover = {
        bg_color = '#01111d',
        fg_color = '#5f7e97'
      },

      new_tab = {
        bg_color = '#01111d',
        fg_color = '#5f7e97'
      },
      new_tab_hover = {
        bg_color = '#01111d',
        fg_color = '#5f7e97'
      }
    }
  else
    -- Light Mode. Based on Solarized light.
    colors.tab_bar = {
      active_tab = {
        bg_color = '#fdf6e3',
        fg_color = '#586e75'
      },

      inactive_tab = {
        bg_color = '#d3cbb7',
        fg_color = '#586e75'
      },
      inactive_tab_edge = '#ddd6c1',
      inactive_tab_hover = {
        bg_color = '#d3cbb7',
        fg_color = '#586e75'
      },

      new_tab = {
        bg_color = '#d3cbb7',
        fg_color = '#586e75'
      },
      new_tab_hover = {
        bg_color = '#d3cbb7',
        fg_color = '#586e75'
      }
    }
  end

  return colors
end

function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return 'Night Owl (Gogh)'
  else
    return 'Solarized (light) (terminal.sexy)'
  end
end

function window_frame_for_appearance(appearance)
  local window_frame

  if appearance:find 'Dark' then
    -- Dark Mode. Based on Night Owl.
    window_frame = {
      inactive_titlebar_bg = '#010e1a',
      active_titlebar_bg   = '#011627',
      active_titlebar_fg   = '#eeefff',
      button_fg            = '#ffffff',
      button_bg            = '#7e57c2',
      button_hover_fg      = '#ffffff',
      button_hover_bg      = '#7e57c2'
    }
  else
    -- Light Mode. Based on Solarized light.
    window_frame = {
      inactive_titlebar_bg = '#eee8d5',
      active_titlebar_bg   = '#eee8d5',
      button_fg            = '#666666',
      button_bg            = '#ac9d57',
      button_hover_fg      = '#333333',
      button_hover_bg      = '#ddd6c1'
    }
  end

  -- Elements common to both colour schemes.
  window_frame.font      = wezterm.font { family = 'Fira Code', weight = 'Regular' }
  window_frame.font_size = 10

  return window_frame
end

config.adjust_window_size_when_changing_font_size = false

config.color_scheme   = scheme_for_appearance(wezterm.gui.get_appearance())
config.colors         = colors_for_appearance(wezterm.gui.get_appearance())
config.enable_wayland = true
config.font           = wezterm.font 'Fira Code'
config.font_size      = 11.0

config.hide_tab_bar_if_only_one_tab = true

config.scrollback_lines = 100000
config.window_frame     = window_frame_for_appearance(wezterm.gui.get_appearance())

config.hyperlink_rules = {
  -- Matches: a URL in parens: (URL)
  {
    regex     = '\\((\\w+://\\S+)\\)',
    format    = '$1',
    highlight = 1,
  },
  -- Matches: a URL in brackets: [URL]
  {
    regex     = '\\[(\\w+://\\S+)\\]',
    format    = '$1',
    highlight = 1,
  },
  -- Matches: a URL in curly braces: {URL}
  {
    regex     = '\\{(\\w+://\\S+)\\}',
    format    = '$1',
    highlight = 1,
  },
  -- Matches: a URL in angle brackets: <URL>
  {
    regex     = '<(\\w+://\\S+)>',
    format    = '$1',
    highlight = 1,
  },
  -- Then handle URLs not wrapped in brackets
  {
    regex  = '\\b\\w+://\\S+[)/a-zA-Z0-9-]+?(?=[\\s]|$)',
    format = '$0',
  },
  -- implicit mailto link
  {
    regex  = '\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b',
    format = 'mailto:$0',
  },
}

config.inactive_pane_hsb = {
  saturation = 0.8,
  brightness = 0.3,
}

config.keys = {
  -- ctrl-v and shift-ctrl-v pastes
  { key = "v", mods = "CTRL", action = wezterm.action({
      PasteFrom = "Clipboard"
  })},
  { key = "v", mods = "CTRL|SHIFT", action = wezterm.action({
      PasteFrom = "Clipboard"
  })},

}

config.window_padding = {
  left   = '2cell',
  right  = '2cell',
  top    = '1cell',
  bottom = '1cell',
}

return config
