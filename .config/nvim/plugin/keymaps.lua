-- Basic keymaps ==============================================================

local map = vim.keymap.set

-- Move by visible lines. Notes:
-- - Don't map in Operator-pending mode because it severely changes behavior:
--   like `dj` on non-wrapped line will not delete it.
-- - Condition on `v:count == 0` to allow easier use of relative line numbers.
map({ "n", "x" }, "j", [[v:count == 0 ? 'gj' : 'j']], { expr = true })
map({ "n", "x" }, "k", [[v:count == 0 ? 'gk' : 'k']], { expr = true })

-- Search inside visually highlighted text. Use `silent = false` for it to
-- make effect immediately.
map("x", "g/", "<esc>/\\%V", { silent = false, desc = "Search inside visual selection" })

-- -- Move inside completion list
-- map("i", "<c-n>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
-- map("i", "<c-p>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })

-- Leader Keymaps =============================================================
-- Create global tables with information about clue groups in certain modes
-- Structure of tables is taken to be compatible with 'mini.clue'.
_G.Config.leader_group_clues = {
  { mode = "n", keys = "<leader>b", desc = "+Buffer" },
}

-- Create <leader> keymaps
local nmap_leader = function(keys, func, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set("n", "<leader>" .. keys, func, opts)
end
local xmap_leader = function(suffix, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set("x", "<leader>" .. suffix, rhs, opts)
end

-- b is for 'buffer'
nmap_leader("ba", "<cmd>b#<cr>", "Alternate")
nmap_leader("bd", "<cmd>lua minibufremove.delete()<cr>", "Delete")
nmap_leader("bD", "<cmd>lua minibufremove.delete(0, true)<cr>", "Delete!")
nmap_leader("bs", "<cmd>lua config.new_scratch_buffer()<cr>", "Scratch")
nmap_leader("bw", "<cmd>lua minibufremove.wipeout()<cr>", "Wipeout")
nmap_leader("bW", "<cmd>lua minibufremove.wipeout(0, true)<cr>", "Wipeout!")

-- e is for 'explore' and 'edit'

-- f is for 'fuzzy find'

-- g is for 'git'

-- l is for 'LSP'
-- nmap_leader("ld", "<cmd>lua vim.diagnostic.open_float()<cr>", "Diagnostics popup")
-- nmap_leader("lj", "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next diagnostic")
-- nmap_leader("lk", "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Prev diagnostic")
-- nmap_leader("lr", "<Cmd>lua vim.lsp.buf.rename()<CR>", "Rename")
-- nmap_leader("lf", formatting_cmd, "Format file")
-- local formatting_cmd = '<cmd>lua require("conform").format({ async = true})<CR>'
nmap_leader("li", "<Cmd>lua vim.lsp.buf.hover()<CR>", "Information")
-- xmap_leader("lf", formatting_cmd, "Format selection")

-- L is for 'Lua'

-- -- terminal
-- vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")
-- -- buffers
-- vim.api.nvim_set_keymap("n", "bk", ":blast<cr>", { noremap = false })
-- vim.api.nvim_set_keymap("n", "bj", ":bfirst<cr>", { noremap = false })
-- vim.api.nvim_set_keymap("n", "bh", ":bprev<cr>", { noremap = false })
-- vim.api.nvim_set_keymap("n", "bl", ":bnext<cr>", { noremap = false })
-- -- vim.api.nvim_set_keymap("n", "td", ":bdelete<cr>", { noremap = false })
-- -- files
-- vim.api.nvim_set_keymap("n", "QQ", ":q!<cr>", { noremap = false })
-- vim.api.nvim_set_keymap("n", "WW", ":w!<cr>", { noremap = false })
-- vim.api.nvim_set_keymap("n", "E", "$", { noremap = false })
-- vim.api.nvim_set_keymap("n", "B", "^", { noremap = false })
-- -- local set = vim.keymap.set
--
-- local map = function(mode, keys, func, opts)
--   if type(opts) == "string" then
--     opts = { desc = opts }
--   end
--
--   vim.keymap.set(mode, keys, func, opts)
-- end
--
-- -- User Friendly Base
-- map("n", "<esc>", "<esc>:nohlsearch<cr>", { silent = true })
-- map("n", "Q", "<nop>")
-- map({ "n", "v" }, "<space>", "<nop>", { silent = true })
--
-- -- Remap for dealing with word wrap
-- map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
--
-- -- Diagnostic keymaps
-- map("n", "[d", vim.diagnostic.goto_prev, "Go to previous diagnostic message")
-- map("n", "]d", vim.diagnostic.goto_next, "Go to next diagnostic message")
-- map("n", "<leader>e", vim.diagnostic.open_float, "Open floating diagnostic message")
-- map("n", "<leader>q", vim.diagnostic.setloclist, "Open diagnostics list")
--
-- map("n", "<C-d>", "<C-d>zz", "Jump Down & Center")
-- map("n", "<C-u>", "<C-u>zz", "Jump Up & Center")
--
-- map("n", "n", "nzzzv", "Jump Next & Center")
-- map("n", "N", "Nzzzv", "Jump Previous & Center")
--
-- map("n", "<leader>ws", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Substitute word under cursor")
-- map("n", "<leader>fn", "<:new<CR>", "Create an empty buffer")
--
-- map({ "n", "v" }, "<leader>y", [["+y]], "Copy selection to OS clipboard")
-- map({ "n", "v" }, "<leader>d", [["_d]], "Delete selection")
--
-- map("v", "J", ":m '>+1<CR>gv=gv", "Move selection down")
-- map("v", "K", ":m '<-2<CR>gv=gv", "Move selection up")
-- map("v", "<leader>p", [["_dP]], "Paste over selection")
--
-- -- Files Management + other useful things
-- map("n", "<leader>cf", "<cmd>let @+ = fnamemodify(expand('%'), ':t')<cr>", "Copy File Name")
-- map("n", "<leader>cp", "<cmd>let @+ = expand('%:p')<cr>", "Copy File Path")
-- map("n", "QQ", "<cmd>q!<cr>", "Quit Without Saving")
--
-- -- Buffers Management
-- map("n", "<c-w>v", "<cmd>vnew<cr>", "New vertical window with an empty buffer")
-- map("n", "tj", "<cmd>bprev<cr>", "Previous buffer")
-- map("n", "tk", "<cmd>bnext<cr>", "Next buffer")
-- -- keymap('n', '<leader>bc', '<cmd>bdelete<CR>', { desc = 'Close buffer' })
--
-- map("i", "<c-c>", "<esc>")
--
-- map("n", "<c-f>", "<cmd>silent !tmux neww tmux-sessionizer<cr>")
--
-- map("n", "<leader>x", "<cmd>!chmod +x %<cr>") --, { silent = true })
-- -- Join the current line with the line below it
-- -- keymap("n", "J", "mzJ'z")
-- -- Opens file in a specified path
-- -- keymap('n', '<leader>vpp', '<cmd>e ~/path<CR>');
