vim.cmd.colorscheme "tokyonight-night"
-- TODO: clean-up previous options
local opt = vim.opt
-- Better replace
opt.inccommand = "split"
-- Line numbers
opt.number = true
opt.relativenumber = true
-- Set highlight on search
opt.hlsearch = true
-- Better search
opt.ignorecase = true -- Case insensitive search UNLESS /C or capital letter in search
opt.smartcase = true
-- Better indentation
opt.autoindent = true
opt.smartindent = true
opt.breakindent = true
-- opt.showbreak = string.rep(" ", 3) -- Make it so that long lines wrap smartly
opt.linebreak = true
-- We say no to wrap
opt.wrap = false
-- Split defaults
opt.splitbelow = true
opt.splitright = true
-- Sign column
opt.signcolumn = "yes"
opt.shada = { "'10", "<0", "s10", "h" }

opt.formatoptions:remove "o"
-- Living on the edge -> or maybe not
opt.swapfile = false
opt.backup = false
opt.undofile = true
-- Shorter updatetime
opt.updatetime = 250

-- opt.timeoutlen = 300
-- opt.title = true
-- -- -- Floating completion window -> command line
-- -- opt.pumblend = 10
-- -- opt.pumheight = 10
-- -- opt.wildmode = "longest:full,full"
-- -- opt.wildoptions = "pum"
-- --
-- -- -- Command Bar
-- -- opt.showmode = false
-- -- opt.showcmd = true
-- -- opt.cmdheight = 1
-- --
-- -- -- Search
-- -- opt.incsearch = true
-- --
-- -- -- opt.shiftwidth = 4
-- -- -- opt.tabstop = 4
-- --
-- -- opt.expandtab = true
-- --
-- -- opt.belloff = "all" -- Just turn the dang bell off -> best option ever!
-- --
-- -- opt.guicursor = "a:block"
-- -- opt.mouse = "a"
-- -- opt.relativenumber = true
-- -- opt.termguicolors = true
-- -- opt.scrollback = 100000
-- -- opt.scrolloff = 8
-- -- opt.signcolumn = "yes"
-- -- opt.colorcolumn = "80"
-- -- opt.splitkeep = "screen"
-- -- opt.splitright = true
-- -- opt.splitbelow = true
-- --
-- -- -- formatoptions and great comments -> credits to tjdevries
-- -- -- implementation - ursusmortiferum
-- -- local formatoptions = {
-- --   a = false, --Auto formatting is bad.
-- --   t = false, -- Don't auto format my code. I got linters for that.
-- --   c = true, -- In general, I like it when comments respect textwidth
-- --   q = true, -- Allow formatting comments w/ gq
-- --   o = false, -- O and o, don't continue comments
-- --   r = true, -- But do continue when pressing enter.
-- --   n = true, -- Indent past the formatlistpat, not underneath it.
-- --   j = true, -- Auto-remove comments if possible.
-- --   ["2"] = false, -- I'm not in gradeschool anymore
-- -- }
-- --
-- -- local function create_options_str(table)
-- --   local options_str = ""
-- --   for key, value in pairs(table) do
-- --     if value == true then
-- --       options_str = options_str .. "fo+=" .. key .. " "
-- --     else
-- --       options_str = options_str .. "fo-=" .. key .. " "
-- --     end
-- --   end
-- --   return options_str
-- -- end
-- --
-- -- vim.cmd("au BufEnter * set " .. create_options_str(formatoptions))
-- --
-- -- -- opt.list = true
-- -- -- opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
-- --
-- -- vim.g.netrw_banner = 0
-- -- vim.g.netrw_liststyle = 3
-- -- vim.g.netrw_browse_split = 0
-- -- vim.g.netrw_winsize = 25
-- --
-- -- -- vim.cmd [[
-- -- -- augroup ProjectDrawer
-- -- --     autocmd!
-- -- --     autocmd VimEnter * :Vexplore
-- -- -- augroup END
-- -- -- ]]
