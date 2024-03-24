return {
    {
        "romgrk/barbar.nvim",
        lazy = false,
        dependencies = {
            "lewis6991/gitsigns.nvim",
            "nvim-tree/nvim-web-devicons",
        },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {
        },
        version = "^1.0.0", -- optional: only update when a new 1.x version is released
        keys = {
            { "<leader>bc", "<cmd>BufferClose<CR>",  { desc = "Close buffer" } },
            { "<leader>b1", "<cmd>BufferGoto 1<CR>", { desc = "Go to buffer 1" } },
            { "<leader>b2", "<cmd>BufferGoto 2<CR>", { desc = "Go to buffer 2" } },
            { "<leader>b3", "<cmd>BufferGoto 3<CR>", { desc = "Go to buffer 3" } },
            { "<leader>b4", "<cmd>BufferGoto 4<CR>", { desc = "Go to buffer 4" } },
            { "<leader>b5", "<cmd>BufferGoto 5<CR>", { desc = "Go to buffer 5" } },
            { "<leader>b6", "<cmd>BufferGoto 6<CR>", { desc = "Go to buffer 6" } },
            { "<leader>b7", "<cmd>BufferGoto 7<CR>", { desc = "Go to buffer 7" } },
            { "<leader>b8", "<cmd>BufferGoto 8<CR>", { desc = "Go to buffer 8" } },
            { "<leader>b9", "<cmd>BufferGoto 9<CR>", { desc = "Go to buffer 9" } },
        },
    },
}
