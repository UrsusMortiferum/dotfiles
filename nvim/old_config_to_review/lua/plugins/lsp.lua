return {
    {
        "neovim/nvim-lspconfig",
        event = "BufReadPre",
        dependencies = {
            { "williamboman/mason.nvim",         config = true }, --,  dependencies = { "nanotee/sqls.nvim" } },
            "williamboman/mason-lspconfig.nvim",
            -- NOTE: `opts = {}` is the same as calling `require("fidget").setup({})`
            { "j-hui/fidget.nvim",               tag = "legacy", opts = {} },
            { "folke/neodev.nvim",               opts = {} },
            { "jose-elias-alvarez/null-ls.nvim", opts = {} },
        },
    },
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        cmd = "Mason",
        keys = {
            { "<leader>lm", "<cmd>Mason<cr>", desc = "Mason" },
        },
    },
}
