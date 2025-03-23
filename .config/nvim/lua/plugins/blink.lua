return {
  {
    "saghen/blink.cmp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      {
        "saghen/blink.compat",
        version = "*",
        lazy = true,
        opts = {},
      },
    },
    version = "*",
    event = "InsertEnter",
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        -- Updates default Tab and S-Tab for snippet movements to C-k and C-j
        ["<C-k>"] = { "snippet_forward", "fallback" },
        ["<C-j>"] = { "snippet_backward", "fallback" },
      },
      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
      },
      completion = {
        menu = { draw = { treesitter = { "lsp" } } },
        documentation = { auto_show = true, auto_show_delay_ms = 200 },
      },
      signature = { enabled = true },
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default", "lazydev" },
  },
}
