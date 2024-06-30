return {
  {
    "epwalsh/obsidian.nvim",
    lazy = true,
    ft = "markdown",
    cmd = {
      "ObsidianNew",
      "ObsidianSearch",
      "ObsidianToday",
      "ObsidianLink",
      "ObsidianLinkNew",
    },
    -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
    -- event = {
    --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    --   "BufReadPre path/to/my-vault/**.md",
    --   "BufNewFile path/to/my-vault/**.md",
    -- },
    config = function()
      require("custom.notes")
    end,

    vim.keymap.set("n", "<leader>nn", "<cmd>ObsidianNew<cr>", { desc = "[N]ew [N]ote" }),
    vim.keymap.set("n", "<leader>sn", "<cmd>ObsidianSearch<cr>", { desc = "[S]earch [N]otes" }),
    vim.keymap.set("n", "<leader>dn", "<cmd>ObsidianToday<cr>", { desc = "[D]aily [N]ote" }),
    vim.keymap.set("n", "<leader>nl", "<cmd>ObsidianLink<cr>", { desc = "[N]ew [L]ink" }),
    vim.keymap.set("n", "<leader>ln", "<cmd>'<,'>ObsidianLinkNew<cr>", { desc = "[L]ink [N]ew - Creates New Note" }),
    vim.keymap.set("n", "<leader>bl", "<cmd>ObsidianBacklinks<cr>", { desc = "View [B]ack[L]inks" }),
  },
}
