-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

config.show_new_tab_button_in_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 0.95
config.color_scheme = "tokyonight_night"
config.adjust_window_size_when_changing_font_size = false
config.font = wezterm.font({
	family = "VictorMono Nerd Font Mono",
	weight = "DemiBold",
})
config.font_size = 13.6

-- config.enable_tab_bar = false

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

-- config.colors = {}
-- config.colors.background = "#111111"

-- config.default_prog = {
--     '/opt/homebrew/bin/fish'
-- }

-- config.window_background_image =
-- '/Users/ursusmortiferum/Library/CloudStorage/OneDrive-Personal/01_Project/Python/welp_mua.png'
-- config.font = wezterm.font 'JetBrains Mono'

-- and finally, return the configuration to wezterm
return config
