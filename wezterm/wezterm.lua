local wezterm = require("wezterm")
local sys, home, d_prog, domain

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
	-- d_prog = {
	-- 	"/opt/homebrew/bin/neofetch",
	-- }
elseif sys == "Windows" then
	domain = "WSL:Ubuntu-22.04"
end

local dimmer = { brightness = 0.05 }

-- TODO: for windows -> ubuntu on launch
-- config.default_prog = {
--     '/opt/homebrew/bin/fish' -- only as a sample, fish should be selected
--				-- as a main shell (Linux and Unix)
-- }
-- default path should be defined in fish

-- TODO: check whether this will work on Windows -> should work, but unfortunately .wezterm.lua is somehow preferred
-- $XDG_CONFIG_HOME/wezterm/wezterm.lua -- for X11/Wayland

local config = wezterm.config_builder()

config.color_scheme = "tokyonight_night"
config.font = wezterm.font({
	family = "VictorMono Nerd Font Mono",
	weight = "DemiBold",
})
config.font_size = 13.6
config.adjust_window_size_when_changing_font_size = false

config.show_new_tab_button_in_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true

config.window_padding = {
	left = "1cell",
	right = "1cell",
	top = "0.5cell",
	bottom = "0.5cell",
}

-- config.window_background_image = { path = bg_path, speed = 0.2 }

config.background = {
	{
		source = {
			File = {
				path = home .. "/.config/wezterm/" .. random_background,
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

config.default_domain = domain

return config
