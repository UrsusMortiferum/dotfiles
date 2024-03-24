return {
    -- {
    --     "mrjones2014/legendary.nvim",
    --     event = "VeryLazy",
    --     keys = {
    --         { "<leader>cp", "<cmd>Legendary<CR>", desc = "[C]ommand [P]alette" },
    --     },
    --     opts = {
    --         which_key = { auto_register = true },
    --     },
    -- },
    {
        "folke/which-key.nvim",
        -- dependencies = {
        --     "mrjones2014/legendary.nvim",
        -- },
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            defaults = {
                prefix = "<leader>",
                mode = "n",
                h = { name = "+Harpoon" },
            },
        },
        -- config = function(_, opts)
        --     local wk = require "which-key"
        --     local keymaps = require "config.remap"
        --     local prefixes = require "config.prefixes"
        --     wk.register(opts.defaults)
        --     wk.register(keymaps.keymaps)
        --     wk.register(keymaps.prefixes)
        -- end,
    },
}
