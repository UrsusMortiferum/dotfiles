return {
    -- "A useless plugin that might help you cope with stubbornly tests or overall lack of sense in life." ~ Eandrju
    {
        "Eandrju/cellular-automaton.nvim",
        keys = {
            -- Yes, make it rain -> it may help you cope with the reality of the world
            { "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>", { desc = "[M]ake it [r]ain" } },
        },
    },
    -- le duck
    {
        "tamton-aquib/duck.nvim",
        keys = {
            { "<leader>dd", "<cmd>lua require('duck').hatch('🦖', 10)<cr>", { desc = "Spawn a dinosaur" } },
            { "<leader>dc", "<cmd>lua require('duck').hatch('🦀', 10)<cr>", { desc = "Spawn a crab" } },
            { "<leader>dk", "<cmd>lua require('duck').cook()<cr>", { desc = "Kill all" } },
        },
    },
}
