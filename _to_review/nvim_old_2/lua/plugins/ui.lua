return {
  {
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    version = false,
    config = function()
      require("mini.statusline").setup()
      require("mini.tabline").setup()
      -- require("mini.icons").setup()
      require("mini.notify").setup()
    end,
  },
  {
    "echasnovski/mini.icons",
    lazy = true,
    version = false,
    init = function()
      -- require("mini.icons").setup()
      package.preload["nvim-web-devicons"] = function()
        require("mini.icons").mock_nvim_web_devicons()
        return package.loaded["nvim-web-devicons"]
      end
    end,
  },
}
