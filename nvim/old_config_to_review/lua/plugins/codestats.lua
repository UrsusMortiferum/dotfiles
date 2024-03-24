return {
    --     {
    --         "https://gitlab.com/code-stats/code-stats-vim",
    --         config = function()
    --             vim.g.codestats_api_key =
    --             "SFMyNTY.VlhKemRYTmZUVzl5ZEdsbVpYSjFiUT09IyNNakEwT0RRPQ.4Eg9Lr8VH94F9SP1Ul7IYGnMEr-fdKfxw1kZjvEmey8"
    --         end,
    --     },
    {
        "YannickFricke/codestats.nvim",
        lazy = false,
        depedencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = {
            token = "SFMyNTY.VlhKemRYTmZUVzl5ZEdsbVpYSjFiUT09IyNNakEwT0RRPQ.4Eg9Lr8VH94F9SP1Ul7IYGnMEr-fdKfxw1kZjvEmey8",
        },
    },
}
