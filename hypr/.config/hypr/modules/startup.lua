---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
terminal = "ghostty"
editor = "nvim"
browser = "helium"
fileManager = "thunar"
menu = "fuzzel"
vpn = "protonvpn-app"
statusBar = "noctalia"

-- -------------------
-- ---- AUTOSTART ----
-- -------------------
--
-- -- See https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function()
  hl.exec_cmd(statusBar)
	hl.exec_cmd(terminal)
	hl.exec_cmd(browser)
  hl.exec_cmd("protonvpn-app --start-minimized")
end)
