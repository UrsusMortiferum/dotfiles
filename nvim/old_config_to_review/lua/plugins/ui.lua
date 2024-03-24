return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd [[
        colorscheme tokyonight-night
        highlight Normal guibg=NONE ctermbg=NONE
        highlight signcolumn guibg=NONE ctermbg=NONE
      ]]
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        lazy = false,
        dependencies = {
            "meuter/lualine-so-fancy.nvim",
            "nvim-tree/nvim-web-devicons"
        },
        opts = {
            options = {
                icons_enabled = true,
                theme = "tokyonight",
                -- component_separators = "|"
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
            },
            globalstatus = true,
            refresh = { statusline = 100 },
            sections = {
                lualine_a = {
                    { "fancy_mode", width = 9 },
                },
                lualine_b = {
                    "branch", "diff"
                },
                lualine_c = {
                    { "filename", file_status = false, path = 1 }
                },
                lualine_x = { "diagnostics", "encoding", "fileformat", "progress", "fancy_location" },
                lualine_y = { "fancy_filetype" },
                lualine_z = { "fancy_lsp_servers" },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
        },
    },
}
