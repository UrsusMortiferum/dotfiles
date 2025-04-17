local M = {}

---Load options
---@param opts? table<string, any>
M.load = function(opts)
  -- Set global options
  -- vim.g.mapleader = " "
  -- vim.g.maplocalleader = "\\"

  local o, opt = vim.o, vim.opt

  -- Override options with user-provided values (if any)
  if opts and opts.options then
    for key, value in pairs(opts.options) do
      vim.opt[key] = value
    end
  end
end

return M
