return {
  "echasnovski/mini.files",
  opts = {
    -- mappings = {
    --   go_in_plus = "l",
    --   go_out_plus = "h",
    -- },
    windows = {
      preview = true,
      width_focus = 30,
      width_preview = 30,
    },
  },
  keys = {
    {
      "-",
      function()
        require("mini.files").open(vim.uv.cwd(), true)
      end,
      desc = "Open mini.files (cwd)",
    },
  },
}
