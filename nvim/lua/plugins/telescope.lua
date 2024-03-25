return {
  {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
      {
        "nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
      },
      "nvim-telescope/telescope-ui-select.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("telescope").setup({
        defaults = { winblend = 10, mapping = { i = { ["<C-u>"] = false, ["<C-d>"] = false } } },
        pickers = {
          oldfiles = { theme = "ivy" },
          buffers = { theme = "ivy" },
          git_files = { theme = "dropdown" },
          find_files = { theme = "dropdown" },
          help_tags = { theme = "dropdown" },
          grep_string = { theme = "dropdown" },
          live_grep = { theme = "dropdown" },
          resume = { theme = "dropdown" },
          diagnostics = { theme = "dropdown" },
          builtin = { theme = "dropdown" },
        },
        extensions = {
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
          file_browser = { theme = "dropdown", hijack_netrw = true },
          ["ui-select"] = { require("telescope.themes").get_dropdown({}) },
          harpoon = { theme = "dropdown" },
        },
      })

      pcall(require("telescope").load_extension, "fzf")
      pcall(require("telescope").load_extension, "file_browser")
      pcall(require("telescope").load_extension, "ui-select")

      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[S]earch [B]buffers" })
      vim.keymap.set("n", "<leader>g", builtin.git_files, { desc = "[S]earch [G]it Files" })
      vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
      vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
      vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
      vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
      vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
      vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
      vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
      vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
      vim.keymap.set("n", "<leader>/", function()
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({ previewer = false }))
      end, { desc = "[/] Fuzzily search in current buffer" })
      vim.keymap.set("n", "<leader>s/", function()
        builtin.live_grep({ grep_open_files = true, prompt_title = "Live Grep In Open Files" })
      end, { desc = "[S]earch [/] in Open Files" })
      vim.keymap.set("n", "<leader>sn", function()
        builtin.find_files({ cwd = vim.fn.stdpath("config") })
      end, { desc = "[S]each [N]eovim files" })
      vim.keymap.set("n", "<leader>fb", ":Telescope file_browser<cr>", { desc = "[F]ile [B]rowser" })
      vim.keymap.set("n", "<leader><tab>", "<cmd>lua require('telescope.builtin').commands()<cr>")

      vim.cmd([[
      highlight TelescopeNormal guibg=NONE ctermbg=NONE blend=0
      highlight TelescopeBorder guibg=NONE ctermbg=NONE blend=0
      ]])
    end,
  },
}
