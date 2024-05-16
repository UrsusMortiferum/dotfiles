vim.opt_local.commentstring = "-- %s"

vim.keymap.set(
  "v",
  "<leader>b",
  ":lua ListToSQLString()<CR>",
  { noremap = true, silent = true, desc = "List to SQL string to simplify life" }
)
