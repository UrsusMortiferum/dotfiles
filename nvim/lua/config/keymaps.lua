vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- local keymap = vim.keymap.set

-- local nmap = function(keys, func, desc)
--   vim.keymap.set("n", keys, func, { desc = desc })
-- end

local map = function(mode, keys, func, opts)
  if type(opts) == "string" then
    opts = { desc = opts }
  end

  vim.keymap.set(mode, keys, func, opts)
end

-- User Friendly Base
map("n", "<esc>", "<esc>:nohlsearch<cr>", { silent = true })
map("n", "Q", "<nop>")
map({ "n", "v" }, "<space>", "<nop>", { silent = true })

-- Remap for dealing with word wrap
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
map("n", "[d", vim.diagnostic.goto_prev, "Go to previous diagnostic message")
map("n", "]d", vim.diagnostic.goto_next, "Go to next diagnostic message")
map("n", "<leader>e", vim.diagnostic.open_float, "Open floating diagnostic message")
map("n", "<leader>q", vim.diagnostic.setloclist, "Open diagnostics list")

map("n", "<leader>pv", vim.cmd.Ex, "Explore")

map("n", "<C-d>", "<C-d>zz", "Jump Down & Center")
map("n", "<C-u>", "<C-u>zz", "Jump Up & Center")

map("n", "n", "nzzzv", "Jump Next & Center")
map("n", "N", "Nzzzv", "Jump Previous & Center")

map("n", "<leader>Y", [["+Y]], "Copy line to OS clipboard")
map("n", "<leader>ws", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Substitute word under cursor")
map("n", "<leader>fn", "<:new<CR>", "Create an empty buffer")

map({ "n", "v" }, "<leader>y", [["+y]], "Copy selection to OS clipboard")
map({ "n", "v" }, "<leader>d", [["_d]], "Delete selection")

map("v", "J", ":m '>+1<CR>gv=gv", "Move selection down")
map("v", "K", ":m '<-2<CR>gv=gv", "Move selection up")
map("v", "<leader>p", [["_dP]], "Paste over selection")

-- Files Management + other useful things
map("n", "<leader>cf", "<cmd>let @+ = fnamemodify(expand('%'), ':t')<cr>", "Copy File Name")
map("n", "<leader>cp", "<cmd>let @+ = expand('%:p')<cr>", "Copy File Path")
map("n", "QQ", "<cmd>q!<cr>", "Quit Without Saving")

-- Buffers Management
map("n", "<leader>ot", "<cmd>new<bar>terminal<cr>", "New horizontal windows with terminal")
map("n", "<c-w>v", "<cmd>vnew<cr>", "New vertical window with an empty buffer")
map("n", "tj", "<cmd>bprev<cr>", "Previous buffer")
map("n", "tk", "<cmd>bnext<cr>", "Next buffer")
-- map("n", "tj", "<cmd>bfirst<cr>", "First Buffer")
-- map("n", "tk", "<cmd>blast<cr>", "Last Buffer")
-- map("n", "th", "<cmd>bprev<cr>", "Previous buffer")
-- map("n", "tl", "<cmd>bnext<cr>", "Next buffer")
-- keymap('n', '<leader>bc', '<cmd>bdelete<CR>', { desc = 'Close buffer' })

-- keymap('n', '<leader><leader>', function()
--     vim.cmd('so')
-- end)

map("i", "<c-c>", "<esc>")

map({ "n", "v" }, "<space>", "<nop>", { silent = true })
map("n", "<c-f>", "<cmd>silent !tmux neww tmux-sessionizer<cr>")

map("n", "<leader>x", "<cmd>!chmod +x %<cr>") --, { silent = true })
map("n", "<leader>x", "<cmd>!python %<cr>")
-- Join the current line with the line below it
-- keymap("n", "J", "mzJ'z")
-- Opens file in a specified path
-- keymap('n', '<leader>vpp', '<cmd>e ~/path<CR>');
