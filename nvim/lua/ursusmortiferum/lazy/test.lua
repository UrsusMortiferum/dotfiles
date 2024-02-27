return {
  "tpope/vim-sleuth",
  {
    "famiu/bufdelete.nvim",
    cmd = { "Bdelete", "Bwipeout" },
    keys = {
      { "<leader>bd", "<cmd>Bdelete<CR>", desc = "Delete buffer" },
      { "<leader>bw", "<cmd>Bwipeout<CR>", desc = "Wipeout buffer" },
    },
  },
  {
    "folke/twilight.nvim",
    cmd = "Twilight", -- toggle twilight
    keys = { { "<leader>tt", "<cmd>Twilight<cr>", desc = "Toggle twilight" } },
    opts = {
      dimming = {
        alpha = 0.25, -- amount of dimming
        -- we try to get the foreground from the highlight groups or fallback color
        color = { "Normal", "#ffffff" },
        term_bg = "#000000", -- if guibg=NONE, this will be used to calculate text color
        inactive = false, -- when true, other windows will be fully dimmed (unless they contain the same buffer)
      },
    },
  },
}
