return {
  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-telescope/telescope-smart-history.nvim",
      "kkharji/sqlite.lua",
    },
    config = function()
      require("custom.telescope")
    end,
  },
}
