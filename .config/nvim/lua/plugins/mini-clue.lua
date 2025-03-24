return {
  "echasnovski/mini.clue",
  version = "*",
  event = "VimEnter",
  config = function()
    local miniclue = require "mini.clue"
    miniclue.setup {
      clues = {
        -- { mode = "n", keys = "<leader>b", desc = "+Buffer" },
        --   { mode = 'n', keys = '<leader>e', desc = '+Explore' },
        -- { mode = "n", keys = "<leader>f", desc = "+Find" },
        -- { mode = "n", keys = "<leader>s", desc = "+Search" },
        -- { mode = "n", keys = "<leader>g", desc = "+Git" },
        -- { mode = "n", keys = "<leader>l", desc = "+LSP" },
        --   { mode = 'n', keys = '<leader>m', desc = '+Map' },
        --   { mode = 'n', keys = '<leader>o', desc = '+Other' },
        --   { mode = 'n', keys = '<leader>r', desc = '+R' },
        --   { mode = 'n', keys = '<leader>t', desc = '+Terminal/Minitest' },
        --   { mode = 'n', keys = '<leader>T', desc = '+Test' },
        -- { mode = "n", keys = "<leader>u", desc = "+Snacks Toggles" },
        --   { mode = 'n', keys = '<leader>v', desc = '+Visits' },
        --   { mode = 'x', keys = '<leader>l', desc = '+LSP' },
        --   { mode = 'x', keys = '<leader>r', desc = '+R' },
        Config.leader_group_clues,
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers { show_contents = true },
        miniclue.gen_clues.windows { submode_resize = true },
        miniclue.gen_clues.z(),
      },
      triggers = {
        -- Leader triggers
        { mode = "n", keys = "<leader>" },
        { mode = "x", keys = "<leader>" },
        -- Built-in completion
        { mode = "i", keys = "<C-x>" },
        -- `g` key
        { mode = "n", keys = "g" },
        { mode = "x", keys = "g" },
        -- Marks
        { mode = "n", keys = "'" },
        { mode = "n", keys = "`" },
        { mode = "x", keys = "'" },
        { mode = "x", keys = "`" },
        -- Registers
        { mode = "n", keys = '"' },
        { mode = "x", keys = '"' },
        { mode = "i", keys = "<C-r>" },
        { mode = "c", keys = "<C-r>" },
        -- Window commands
        { mode = "n", keys = "<C-w>" },
        -- `z` key
        { mode = "n", keys = "z" },
        { mode = "x", keys = "z" },
        { mode = "n", keys = "[" },
        { mode = "n", keys = "]" },
      },
      window = {
        delay = 100,
        config = {
          width = "auto",
          border = "rounded",
        },
      },
    }
  end,
}
