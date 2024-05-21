return {
  {
    "kndndrj/nvim-dbee",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    build = function()
      require("dbee").install("go")
    end,
    config = function()
      require("dbee").setup(--[[optional config]])
    end,
  },
}
