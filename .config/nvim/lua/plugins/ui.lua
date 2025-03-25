return {
  {
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    config = function()
      require("mini.statusline").setup()
      require("mini.tabline").setup()
      require("mini.icons").setup()
    end,
  },
}
