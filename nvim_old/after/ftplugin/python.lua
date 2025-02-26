vim.cmd("setlocal colorcolumn=89")

vim.g.pyindent_open_paren = "shiftwidth()"
vim.g.pyindent_continue = "shiftwidth()"

vim.keymap.set("x", "<leader>x", "<cmd>lua PythonExecuteSelection()<cr>", { desc = "Execute selected lines" })
vim.keymap.set("n", "<leader><leader>x", "<cmd>!python %<cr>", { desc = "Execute the current file" })

local function set_python_provider()
  local path = vim.fn.exepath("python")

  if path ~= "" then
    vim.g.python3_host_prog = path
  else
    vim.api.nvim_err_writeln("Python executable not found in $PATH")
  end
end

vim.api.nvim_create_autocmd("BufEnter", {
  callback = set_python_provider,
})
