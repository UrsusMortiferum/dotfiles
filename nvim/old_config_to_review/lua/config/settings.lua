vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.autoindent = true
opt.breakindent = true
opt.smartindent = true
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.hlsearch = false
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.completeopt = "menuone,noselect"
opt.guicursor = "a:block"
opt.nu = true
opt.relativenumber = true
opt.wrap = false
opt.termguicolors = true
opt.scrollback = 100000
opt.scrolloff = 8
opt.pumblend = 10
opt.pumheight = 10
opt.mouse = "a"
opt.signcolumn = "yes"
opt.colorcolumn = "80"
opt.splitkeep = "screen"
opt.splitright = true
opt.timeoutlen = 300
opt.updatetime = 250
opt.timeout = true
opt.title = true
opt.swapfile = false
opt.backup = false
opt.undofile = true
opt.wildmode = "longest:full,full"

vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 25

-- vim.opt.guicursor = "a:block"
-- vim.o.guicursor = ""

-- See `:help vim.o`
-- Sync clipboard between OS and Neovim.
-- vim.o.clipboard = "unnamedplus"
-- Supposedly useful for the file management, etc. will need to explore it later
-- vim.o.isfname:append("@-@")
-- sets the directory where undo files are stored
-- vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"
