local wezterm = require 'wezterm'
local config = wezterm.config_builder()

--- Config Starts
config.font = wezterm.font 'monospace'
config.font_size = 11

config.color_scheme = 'Tomorrow Night Bright'
config.window_background_opacity = 0.75
config.colors = {
    selection_fg = 'black',
    selection_bg = 'white',
}

config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

config.enable_tab_bar = false
config.enable_scroll_bar = true
config.window_close_confirmation = 'NeverPrompt'
--- Config Ends

return config
