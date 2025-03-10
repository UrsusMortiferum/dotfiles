vim.cmd "setlocal colorcolumn=120"
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.keymap.set("n", "<leader><leader>x", "<cmd>source %<cr>", { desc = "Execute the current file" })
vim.keymap.set("n", "<leader>x", "<cmd>.lua<cr>", { desc = "Execute the current line" })
