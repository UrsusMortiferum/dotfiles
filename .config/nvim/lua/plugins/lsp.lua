return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- {
      --   "folke/lazydev.nvim",
      --   ft = "lua",
      --   opts = {
      --     library = {
      --       { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      --     },
      --   },
      -- },
      {
        "williamboman/mason.nvim",
        opts = {},
      },
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
      require "config.lsp"
    end,
  },
}
