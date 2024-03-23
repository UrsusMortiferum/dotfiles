local wezterm = require("wezterm")
local sys, home, bg_path

if wezterm.target_triple:find("linux") then
	home = os.getenv("HOME")
	sys = "Linux"
elseif wezterm.target_triple:find("darwin") then
	home = os.getenv("HOME")
	sys = "Unix"
elseif wezterm.target_triple:find("windows") then
	home = os.getenv("USERPROFILE")
	sys = "Windows"
end

local backgrounds = {
	"rainy_smoke.gif",
	"endless_walk.gif",
	"cyberpunk.gif",
	"pixel_jeff_night_shift.gif",
	"mario.gif",
	"witch.gif",
	"penguins.png",
}
local random_index = math.random(1, #backgrounds)
local random_background = backgrounds[random_index]

if sys == "Unix" or "Linux" then
	bg_path = home .. "/.config/wezterm/" .. random_background
elseif sys == "Windows" then
	bg_path = home .. "\\AppData\\Local\\wezterm\\" .. random_background
end

local dimmer = { brightness = 0.05 }

-- $XDG_CONFIG_HOME/wezterm/wezterm.lua -- for X11/Wayland

local config = wezterm.config_builder()

config.show_new_tab_button_in_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

config.color_scheme = "tokyonight_night"
config.font = wezterm.font({
	family = "VictorMono Nerd Font Mono",
	weight = "DemiBold",
})
config.font_size = 13.6
config.adjust_window_size_when_changing_font_size = false

config.background = {
	{
		source = {
			File = {
				path = bg_path,
				speed = 0.2,
			},
		},
		hsb = dimmer,
		-- vertical_align = "Middle",
		-- horizontal_align = "Center",
		-- opacity = 0.95,
		-- height = "Contain",
		-- width = "Contain",
	},
}

-- config.default_prog = {
--     '/opt/homebrew/bin/fish'
-- }

return config
