------------------
---- MONITORS ----
------------------
-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

-- Main 16x9 monitor
hl.monitor({
	output = "HDMI-A-2",
	mode = "3840x2160@120",
	position = "0x0",
	scale = 1,
	bitdepth = 10,
	cm = "auto",
	vrr = 3,
	supports_wide_color = 1,
	supports_hdr = 1,
})

-- GPD
hl.monitor({
	output = "eDP-1",
	mode = "highres",
	position = "auto",
	scale = 2,
})

-- LG monitor
hl.monitor({
	output = "desc:Lenovo Group Limited LEN G34w-10 UGW0394A",
	mode = "3440x1440@144",
	position = "0x0",
	scale = 1,
	vrr = 3,
})

-- Random monitors
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })
