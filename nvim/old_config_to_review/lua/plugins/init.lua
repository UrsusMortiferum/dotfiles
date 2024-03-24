return {
    "nvim-lua/plenary.nvim",
    { "nvim-tree/nvim-web-devicons", config = true },
    "tpope/vim-sleuth",
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufReadPre",
        opts = {
            char = "┊",
            space_char_blankline = " ",
            show_trailing_blankline_indent = false,
            show_current_context = true,
            show_current_context_start = true,
        },
    },
    {
        "numToStr/Comment.nvim",
        opts = {},
        lazy = false,
    },
    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
        opts = {
            input = { relative = "editor" },
            select = {
                backend = { "telescope", "fzf", "builtin" },
            },
        },
    },
    -- {
    --     "stevearc/dressing.nvim",
    --     event = "VeryLazy",
    --     config = true,
    -- },
    {
        "sindrets/diffview.nvim",
        cmd = {
            "DiffviewOpen",
            "DiffviewClose",
            "DiffviewToggleFiles",
            "DiffviewFocusFiles",
        },
        config = true,
    },
    {
        "TimUntersberger/neogit",
        cmd = "Neogit",
        opts = {
            integrations = { diffview = true },
        },
        keys = {
            { "<leader>gs", "<cmd>Neogit kind=floating<cr>", desc = "Neogit status" },
        },
    },
}
