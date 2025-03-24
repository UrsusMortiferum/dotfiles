-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup {
  spec = {
    { import = "plugins" },
  },
  -- dev = {
  --   -- Directory where you store your local plugin projects. If a function is used,
  --   -- the plugin directory (e.g. `~/projects/plugin-name`) must be returned.
  --   ---@type string | fun(plugin: LazyPlugin): string
  --   path = "~/projects",
  --   ---@type string[] plugins that match these patterns will use your local versions instead of being fetched from GitHub
  --   patterns = {}, -- For example {"folke"}
  --   fallback = false, -- Fallback to git when local plugin doesn't exist
  -- },
  install = { colorscheme = { "tokyonight-night", "habamax" } },
  checker = { enabled = true, notify = false },
  performance = {
    rtp = {
      -- paths = { vim.fn.stdpath "config" .. "/plugin" },
      --     -- disable some rtp plugins
      --     disabled_plugins = {
      --       "gzip",
      --       -- "matchit",
      --       -- "matchparen",
      --       -- "netrwPlugin",
      --       "tarPlugin",
      --       "tohtml",
      --       "tutor",
      --       "zipPlugin",
      --     },
    },
  },
}
