return {
  "um", -- Unique name (can be anything)
  lazy = false,
  enabled = false,
  priority = 1000,
  dir = "~/.config/nvim/lua/um", -- Path to your plugin directory
  config = function()
    require("um").setup {
      -- Optional configuration options
      -- options = { ... },
      -- mappings = { ... },
      -- autocommands = { ... },
    }
  end,
}
