-- function PythonAssignment()
--   local sys_info = vim.loop.os_uname()
--   local os_type = sys_info.sysname
--   local home = os.getenv("HOME") or os.getenv("USERPROFILE")
--
--   if os_type == "Windows_NT" then
--     local path = home .. "\\AppData\\Local\\anaconda3\\envs\\py3.11.4\\python.exe"
--     print("Setting python3_host_prog:", path)
--     vim.g.python3_host_prog = path
--   elseif os_type == "Darwin" then
--     local path = home .. "/anaconda3/envs/py3.11.3/bin/python"
--     print("Setting python3_host_prog:", path)
--     vim.g.python3_host_prog = path
--   else
--     print("Whelp, you are not done with configuring python provider yet")
--     print("Little helper, here is the system you are using now: ", os_type)
--   end
-- end
--
-- PythonAssignment()

if vim.loader then
  vim.loader.enable()
end

require("config.options")
require("config.keymaps")
require("config.lazy")
require("config.autocmds")

-- vim.api.nvim_create_autocmd("User", {
--    pattern = "VeryLazy",
--    callback = function()
--       require("util").version()
--    end,
-- })
