local keymap = vim.keymap.set

keymap("n", "<leader>pv", vim.cmd.Ex, { desc = "Explore" })

keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

keymap("n", "<leader>Y", [["+Y]], { desc = "Copy line to OS clipboard" })
keymap("n", "<leader>sw", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Substitute word under cursor" })
keymap("n", "<leader>ff", vim.lsp.buf.format, { desc = "[F]ile [F]ormat" })
keymap("n", "<leader>fn", "<:enew<CR>", { desc = "Create an empty buffer" })

keymap({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy selection to OS clipboard" })
keymap({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete selection" })

keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
keymap("v", "<leader>p", [["_dP]], { desc = "Paste over selection" })

keymap("n", "<leader>bc", "<cmd>BufferClose<CR>", { desc = "Close buffer" })
keymap("n", "<leader>b1", "<cmd>BufferGoto 1<CR>", { desc = "Go to buffer 1" })
keymap("n", "<leader>b2", "<cmd>BufferGoto 2<CR>", { desc = "Go to buffer 2" })
keymap("n", "<leader>b3", "<cmd>BufferGoto 3<CR>", { desc = "Go to buffer 3" })
keymap("n", "<leader>b4", "<cmd>BufferGoto 4<CR>", { desc = "Go to buffer 4" })
keymap("n", "<leader>b5", "<cmd>BufferGoto 5<CR>", { desc = "Go to buffer 5" })
keymap("n", "<leader>b6", "<cmd>BufferGoto 6<CR>", { desc = "Go to buffer 6" })
keymap("n", "<leader>b7", "<cmd>BufferGoto 7<CR>", { desc = "Go to buffer 7" })
keymap("n", "<leader>b8", "<cmd>BufferGoto 8<CR>", { desc = "Go to buffer 8" })
keymap("n", "<leader>b9", "<cmd>BufferGoto 9<CR>", { desc = "Go to buffer 9" })

-- keymap("n", "<leader><leader>", function()
--     vim.cmd("so")
-- end)

keymap("i", "<C-c>", "<Esc>")

keymap("n", "<leader>tt", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })
keymap("n", "<leader>tr", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh NvimTree" })
--
--
--
keymap("n", "Q", "<nop>")
keymap("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

keymap("n", "<leader>x", "<cmd>!chmod +x %<CR>") --, { silent = true })
keymap("n", "<leader>x", "<cmd>!python %<CR>")
-- Join the current line with the line below it
-- keymap("n", "J", "mzJ'z")
-- Opens file in a specified path
-- keymap("n", "<leader>vpp", "<cmd>e ~/path<CR>");
keymap("n", "<leader>vwm", function()
    require("vim-with-me").StartVimWithMe()
end)
keymap("n", "<leader>svwm", function()
    require("vim-with-me").StopVimWithMe()
end)

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
keymap("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
keymap("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
keymap("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
