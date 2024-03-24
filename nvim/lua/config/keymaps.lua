vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap.set

-- User Friendly Base
keymap("n", "<Esc>", "<esc>:nohlsearch<cr>", { silent = true })
keymap("n", "Q", "<Nop>")
keymap({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
keymap("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
keymap("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
keymap("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
keymap("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

keymap("n", "<leader>pv", vim.cmd.Ex, { desc = "Explore" })

keymap("n", "<C-d>", "<C-d>zz", { desc = "Jump Down & Center" })
keymap("n", "<C-u>", "<C-u>zz", { desc = "Jump Up & Center" })

keymap("n", "n", "nzzzv", { desc = "Jump Next & Center" })
keymap("n", "N", "Nzzzv", { desc = "Jump Previous & Center" })

keymap("n", "<leader>Y", [["+Y]], { desc = "Copy line to OS clipboard" })
keymap(
  "n",
  "<leader>ws",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "Substitute word under cursor" }
)
-- keymap("n", "<leader>ff", vim.lsp.buf.format, { desc = "[F]ile [F]ormat" })
keymap("n", "<leader>fn", "<:new<CR>", { desc = "Create an empty buffer" })

keymap({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy selection to OS clipboard" })
keymap({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete selection" })

keymap("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
keymap("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
keymap("v", "<leader>p", [["_dP]], { desc = "Paste over selection" })

-- Files Management + other useful things
keymap("n", "<leader>cf", "<cmd>let @+ = fnamemodify(expand('%'), ':t')<cr>", { desc = "Copy File Name" })
keymap("n", "<leader>cp", "<cmd>let @+ = expand('%:p')<cr>", { desc = "Copy File Path" })
keymap("n", "QQ", "<cmd>q!<cr>", { desc = "Quit Without Saving" })

-- Buffers Management
keymap("n", "tj", "<cmd>bfirst<cr>", { desc = "First Buffer" })
keymap("n", "tk", "<cmd>blast<cr>", { desc = "Last Buffer" })
keymap("n", "th", "<cmd>bprev<cr>", { desc = "Previous buffer" })
keymap("n", "tl", "<cmd>bnext<cr>", { desc = "Next buffer" })
-- keymap('n', '<leader>bc', '<cmd>bdelete<CR>', { desc = 'Close buffer' })

-- keymap('n', '<leader><leader>', function()
--     vim.cmd('so')
-- end)

keymap("i", "<C-c>", "<Esc>")
--
--
keymap({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
keymap("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

keymap("n", "<leader>x", "<cmd>!chmod +x %<CR>") --, { silent = true })
keymap("n", "<leader>x", "<cmd>!python %<CR>")
-- Join the current line with the line below it
-- keymap("n", "J", "mzJ'z")
-- Opens file in a specified path
-- keymap('n', '<leader>vpp', '<cmd>e ~/path<CR>');
