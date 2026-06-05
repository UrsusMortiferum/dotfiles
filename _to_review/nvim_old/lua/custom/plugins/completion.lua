return {
  {
    "hrsh7th/nvim-cmp",
    -- lazy = false,
    -- priority = 100,
    event = "InsertEnter",
    dependencies = {
      "onsails/lspkind.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-emoji",
      {
        "Exafunction/codeium.nvim",
        cmd = "Codeium",
        build = ":Codeium Auth",
        opts = {},
      },
      { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require("custom.completion")
    end,
  },
}
