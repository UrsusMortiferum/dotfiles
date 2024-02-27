return {
  {
    "eandrju/cellular-automaton.nvim",
    cmd = "CellularAutomaton",
  },
  {
    "ThePrimeagen/vim-be-good",
    cmd = "VimBeGood",
    keys = { { "<leader>vbg", "<cmd>VimBeGood<cr>", desc = "Vim Be Good Baby" } },
  },
  {
    "m4xshen/hardtime.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    opts = {},
  },
}
