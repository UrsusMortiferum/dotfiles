local data = assert(vim.fn.stdpath("data")) --[[@as string]]

require("telescope").setup({
  extensions = {
    fzf = {
      -- fuzzy = true, -- false will only do exact matching
      -- override_generic_sorter = true, -- override the generic sorter
      -- override_file_sorter = true, -- override the file sorter
      -- case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      -- -- the default case_mode is "smart_case"
    },
    wrap_results = true,
    history = {
      path = vim.fs.joinpath(data, "telescope_history.sqlite3"),
      limit = 100,
    },
  },
  defaults = { path_display = { "filename_first" } },
  pickers = {
    oldfiles = { theme = "ivy" },
    buffers = { theme = "ivy" },
    -- git_files = { theme = "dropdown" },
    -- find_files = { theme = "dropdown" },
    -- help_tags = { theme = "dropdown" },
    -- grep_string = { theme = "dropdown" },
    -- live_grep = { theme = "dropdown" },
    -- resume = { theme = "dropdown" },
    -- diagnostics = { theme = "dropdown" },
    current_buffer_fuzzy_find = {
      theme = "dropdown",
      previewer = false,
    },
  },
})

pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "smart_history")

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>/", builtin.current_buffer_fuzzy_find)
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "[S]earch [B]buffers" })
vim.keymap.set("n", "<leader>g", builtin.git_files, { desc = "[S]earch [G]it Files" })
vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<leader><tab>", "<cmd>lua require('telescope.builtin').commands()<cr>")

vim.keymap.set("n", "<leader>fa", function()
  ---@diagnostic disable-next-line: param-type-mismatch
  builtin.find_files({ cwd = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy") })
end)

vim.keymap.set("n", "<leader>en", function()
  builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[S]each [N]eovim files" })

-- vim.keymap.set("n", "<leader>/", function()
--   builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({ previewer = false }))
-- end, { desc = "[/] Fuzzily search in current buffer" })
-- vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
-- vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
-- vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
-- vim.keymap.set("n", "<leader>s/", function()
--   builtin.live_grep({ grep_open_files = true, prompt_title = "Live Grep In Open Files" })
-- end, { desc = "[S]earch [/] in Open Files" })
