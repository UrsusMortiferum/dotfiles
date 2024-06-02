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
        -- inactive = false, -- whentrue, other windows will be fully dimmed (unless they contain the same buffer)
        inactive = true,
      },
    },
  },
  -- {
  --   "kndndrj/nvim-dbee",
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --   },
  --   build = function()
  --     require("dbee").install("go")
  --   end,
  --   config = function()
  --     require("dbee").setup(--[[optional config]])
  --   end,
  -- },
  -- "tpope/vim-dadbod",
  -- "kristijanhusak/vim-dadbod-completion",
  -- "kristijanhusak/vim-dadbod-ui",
  -- {
  --   "xemptuous/sqlua.nvim",
  --   lazy = true,
  --   cmd = "SQLua",
  --   config = function()
  --     require("sqlua").setup()
  --   end,
  -- },
}
