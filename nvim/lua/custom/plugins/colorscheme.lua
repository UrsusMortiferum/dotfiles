return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night",
        transparent = true,
        terminal_colors = true,
        styles = {
          comments = { italic = false },
          keywords = { italic = false },
          sidebars = "transparent",
          floats = "transparent",
        },
        on_colors = function(colors) end,
        on_highlights = function(highlights, colors) end,
      })

      vim.cmd("colorscheme tokyonight")
    end,
  },
}
