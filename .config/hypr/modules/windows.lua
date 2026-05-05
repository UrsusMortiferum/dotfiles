--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
	-- Fix some dragging issues with XWayland
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },

	move = "20 monitor_h-120",
	float = true,
})

hl.window_rule({
	name = "picture-in-picture",
	match = {
		title = "(?i)\\bpicture[-_\\s]*in[-_\\s]*picture\\b",
	},
	float = true,
	pin = true,
	size = { "monitor_w * 0.2", "monitor_h * 0.2" },
	move = { 20, "monitor_h - monitor_h * 0.2 - 20" },
})

hl.window_rule({
	name = "Steam - base behavior and silent launch",
	match = {
		class = "steam",
		title = ".+",
	},
	workspace = "9 silent",
	float = true,
	center = true,
	size = { "monitor_w * 0.3", "monitor_h * 0.4" },
})

hl.window_rule({
	name = "Steam - tile main window",
	match = {
		class = "steam",
		title = "Steam",
	},
	tile = true,
})

hl.window_rule({
	name = "Steam - friends list",
	match = {
		class = "steam",
		title = "Friends List",
	},
	size = { "monitor_w * 0.1", "monitor_h * 0.25" },
	move = { "monitor_w - 20 - monitor_w * 0.1", "monitor_h - 20 - monitor_h * 0.25" },
	opacity = "1.0 0.5 1.0",
})
