local wezterm = require("wezterm")

local home, dir

local backgrounds = {
  "rainy_smoke.gif",
  "endless_walk.gif",
  "cyberpunk.gif",
  "mario.gif",
  "witch.gif",
  "penguins.png",
}
local random_index = math.random(1, #backgrounds)
local random_background = backgrounds[random_index]

if wezterm.target_triple:find("windows") then
  home = os.getenv("USERPROFILE")
  dir = home .. "/.config/wezterm/gifs/" .. random_background
else
  home = os.getenv("HOME")
  dir = home .. "/.config/wezterm/gifs/" .. random_background
end

local dimmer = { brightness = 0.03 }

return {
  color_scheme = "tokyonight_night",
  font = wezterm.font({
    family = "VictorMono Nerd Font",
    weight = "DemiBold",
  }),
  font_size = 13.6,
  adjust_window_size_when_changing_font_size = false,

  -- Tab bar
  show_new_tab_button_in_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  use_fancy_tab_bar = false,
  tab_bar_at_bottom = true,

  background = {
    {
      source = {
        File = {
          path = dir,
          speed = 0.2,
        },
      },
      hsb = dimmer,
      vertical_align = "Middle",
      horizontal_align = "Center",
      -- opacity = 0.95,
      -- height = "Contain",
      -- width = "Contain",
    },
  },
  window_decorations = "RESIZE",
  -- TODO: Review key bindings
  -- disable_default_key_bindings = true
}
