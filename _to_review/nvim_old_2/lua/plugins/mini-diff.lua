return {
  "echasnovski/mini.diff",
  event = "VeryLazy",
  keys = {
    {
      "<leader>go",
      function()
        require("mini.diff").toggle_overlay(0)
      end,
      desc = "Toggle mini.diff overlay",
    },
  },
  config = function()
    require("mini.diff").setup()
  end,
}
