return {
  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.align").setup()
      require("mini.cursorword").setup()
      require("mini.git").setup()
      require("mini.statusline").setup()
      require("mini.tabline").setup()
    end,
    version = "*",
  },
}
