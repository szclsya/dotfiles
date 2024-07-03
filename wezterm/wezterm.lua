local wezterm = require 'wezterm'
local config = wezterm.config_builder()

--- Config Starts
config.font = wezterm.font 'monospace'
config.font_size = 11
config.font_rules = {
    {
        intensity = "Bold",
        font = wezterm.font({ family = "monospace", weight = "ExtraBold" }),
    },
    {
        intensity = "Half",
        font = wezterm.font({ family = "monospace", weight = "Light" }),
    }
}

config.window_background_opacity = 0.75
config.colors = {
    foreground = "#eaeaea",
    background = "#000000",
    ansi = {"#000000","#d54e53","#b9ca4a","#e7c547","#7aa6da","#c397d8","#70c0b1","#ffffff"},
    brights = {"#666666","#d54e53","#b9ca4a","#e7c547","#7aa6da","#c397d8","#70c0b1","#ffffff"},
    selection_fg = 'black',
    selection_bg = '#e7e7e7',
    cursor_fg = 'black',
    cursor_border = "#eaeaea",
    cursor_bg = 'white',
}

config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}

config.enable_tab_bar = false
config.enable_scroll_bar = false
config.window_close_confirmation = 'NeverPrompt'
--- Config Ends

return config
