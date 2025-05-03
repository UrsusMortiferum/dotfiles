return {
  {
    "neovim/nvim-lspconfig",
    -- event = "LazyFile",
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = {},
      },
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      -- { "j-hui/fidget.nvim", opts = {} },
    },
    config = function()
      require "config.lsp"
    end,
  },
}
