local config = require "um.config"

local M = {}

---@param opts? table<string, any>
function M.setup(opts)
  config.load_options(opts)
  config.load_mappings(opts)
  config.load_autocommands(opts)
end

return M
