-- -- Leader Keymaps =============================================================
-- -- Create global tables with information about clue groups in certain modes
-- -- Structure of tables is taken to be compatible with 'mini.clue'.
-- _G.Config.leader_group_clues = {
--   { mode = "n", keys = "<leader>b", desc = "+Buffer" },
-- }

local Plugin = require("lazy.core.plugin")

local M = {}

M.lazy_file_events = { "BufReadPost", "BufNewFile", "BufWritePre" }

function M.is_win()
  return vim.uv.os_uname().sysname:find "Windows" ~= nil
end

function M.is_wsl()
  return vim.fn.has "wsl" == 1
end

function M.lazy_file()
  local Event = require "lazy.core.handler.event"

  Event.mappings.LazyFile = { id = "LazyFile", event = M.lazy_file_events }
  Event.mappings["User LazyFile"] = Event.mappings.LazyFile
end

return M
