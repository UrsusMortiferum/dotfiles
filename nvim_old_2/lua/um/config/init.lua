local M = {}

---Load options
---@param opts? table<string, any>
M.load_options = function(opts)
  local options = require "um.config.options"
  options.load(opts)
end

---Load mappings
---@param opts? table<string, any>
M.load_mappings = function(opts)
  local mappings = require "um.config.mappings"
  mappings.load(opts)
end

---Load autocommands
---@param opts? table<string, any>
M.load_autocommands = function(opts)
  local autocommands = require "um.config.autocommands"
  autocommands.load(opts)
end

return M
