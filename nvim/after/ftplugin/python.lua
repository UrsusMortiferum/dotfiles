vim.cmd("setlocal colorcolumn=89")

vim.g.pyindent_open_paren = "shiftwidth()"
vim.g.pyindent_continue = "shiftwidth()"

vim.keymap.set("x", "<leader>x", "<cmd>lua PythonExecuteSelection()<cr>", { desc = "Execute selected lines" })
vim.keymap.set("n", "<leader><leader>x", "<cmd>!python %<cr>", { desc = "Execute the current file" })
