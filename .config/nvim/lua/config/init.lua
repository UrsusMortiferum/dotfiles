_G.Config = require "util"

local M = {}

Config.config = M

local defaults = {
  colorscheme = function()
    -- require("tokyonight").load()
    require("kanagawa").load()
  end,
  defaults = {
    autocmds = true, -- config.autocmds
    keymaps = true, -- config.keymaps
    options = true, -- config.options
  },
}

for k, v in pairs(defaults) do
  M[k] = v
end

function M.setup()
  -- local group = vim.api.nvim_create_augroup("CustomSettings_", { clear = true })
  -- vim.api.nvim_create_autocmd("User", {
  --   group = group,
  --   pattern = "VeryLazy",
  --   callback = function()
  --     M.load "autocmds"
  --     M.load "keymaps"
  --     if Config.is_wsl() then
  --       print "finish this"
  --     end
  --   end,
  -- })

  M.load_colorscheme()
end

---@param name "autocmds" | "options" | "keymaps"
function M.load(name)
  if M.defaults[name] or name == "options" then
    require("config." .. name)
  end
end

M.did_init = false
function M.init()
  if M.did_init then
    return
  end
  M.did_init = true

  M.load "options"
end

function M.load_colorscheme()
  local status, result = pcall(function()
    if type(M.colorscheme) == "function" then
      M.colorscheme()
    else
      vim.cmd.colorscheme(M.colorscheme)
    end
  end)

  if not status then
    print("Failed to load colorscheme: " .. result)
    vim.cmd.colorscheme "habamax"
  end
end

return M
