return {
    -- Fuzzy Finder (files, lsp, etc)
    {
        "nvim-telescope/telescope.nvim",
        -- branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons" },
        cmd = "Telescope",
        -- keys = {
        --     { "<leader>?",       require("telescope.builtin").oldfiles,    { desc = "[?] Find recently opened files" } },
        --     { "<leader><space>", require("telescope.builtin").buffers,     { desc = "[ ] Find existing buffers" } },
        --     { "<leader>gf",      require("telescope.builtin").git_files,   { desc = "Search [G]it [F]iles" } },
        --     { "<leader>sf",      require("telescope.builtin").find_files,  { desc = "[S]earch [F]iles" } },
        --     { "<leader>sh",      require("telescope.builtin").help_tags,   { desc = "[S]earch [H]elp" } },
        --     { "<leader>sw",      require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" } },
        --     { "<leader>sg",      require("telescope.builtin").live_grep,   { desc = "[S]earch by [G]rep" } },
        --     { "<leader>sd",      require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" } },
            --     { "<leader>/", function()  require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
            --             winblend = 10,
            --             previewer = false,
            --         })
            --     end, { desc = "[/] Fuzzily search in current buffer" } },
        -- },
    },

    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = "make",
        cond = function()
            return vim.fn.executable "make" == 1
        end,
    },
    --     {
    --         "nvim-telescope/telescope-file-browser.nvim",
    --         dependencies = {
    --             "nvim-telescope/telescope.nvim",
    --             "nvim-lua/plenary.nvim" }
    --     }
}

-- require("telescope").setup {
--     extenstions = {
--         file_browser = {
--             hijack_netrw = true,
--         }
--     }
-- }
