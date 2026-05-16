---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
terminal = "ghostty"
editor = "nvim"
browser = "helium"
fileManager = "thunar"
menu = "hyprlauncher"
vpn = "protonvpn-app"

-- -------------------
-- ---- AUTOSTART ----
-- -------------------
--
-- -- See https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function()
  hl.exec_cmd("noctalia-shell")
	hl.exec_cmd(terminal)
	hl.exec_cmd(browser)
	hl.exec_cmd(vpn)
end)
