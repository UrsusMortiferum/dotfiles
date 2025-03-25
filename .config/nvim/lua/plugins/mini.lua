return {
  {
    "echasnovski/mini.nvim",
    config = function()
      require("mini.bufremove").setup()
      require("mini.align").setup()
      require("mini.cursorword").setup()
      require("mini.git").setup()
    end,
    version = "*",
  },
}
