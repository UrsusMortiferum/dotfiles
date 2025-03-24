local o = vim.o

-- General ====================================================================
o.backup = false -- Don't store backup
o.mouse = "a" -- Enable mouse
o.mousescroll = "ver:25,hor:6" -- Customize mouse scroll
o.switchbuf = "usetab" -- Use already opened buffers when switching
o.writebackup = false -- Don't store backup (better performance)
o.undofile = true -- Enable persistent undo

-- TODO: check this later
-- opt.shada = { "'10", "<0", "s10", "h" }
vim.o.shada = "'100,<50,s10,:1000,/100,@100,h" -- Limit what is stored in ShaDa file

vim.cmd "filetype plugin indent on" -- Enable all filetype plugins

-- UI =========================================================================
o.breakindent = true -- Indent wrapped lines to match line start
o.colorcolumn = "+1" -- Draw colored column one step to the right of desired maximum width
o.cursorline = true -- Enable highlighting of the current line
o.linebreak = true -- Wrap long lines at 'breakat' (if 'wrap' is set)
o.list = true -- Show helpful character indicators
o.number = true -- Show line numbers
o.relativenumber = true -- Show the line number relative to cursor position
o.pumheight = 10 -- Make popup menu smaller
o.ruler = false -- Don't show cursor position
o.shortmess = "FOSWaco" -- Disable certain messages from |ins-completion-menu|
o.showmode = false -- Don't show mode in command line
o.signcolumn = "yes" -- Always show signcolumn or it would frequently shift
o.splitbelow = true -- Horizontal splits will be below
o.splitright = true -- Vertical splits will be to the right
o.wrap = false -- Display long lines as just one line

vim.o.fillchars = table.concat(
  -- Special UI symbols
  {
    "eob: ",
    "fold:╌",
    "horiz:═",
    "horizdown:╦",
    "horizup:╩",
    "vert:║",
    "verthoriz:╬",
    "vertleft:╣",
    "vertright:╠",
  },
  ","
)
vim.o.listchars = table.concat({ "extends:…", "nbsp:␣", "precedes:…", "tab:> " }, ",") -- Special text symbols
vim.o.cursorlineopt = "screenline,number" -- Show cursor line only screen line when wrapped
vim.o.breakindentopt = "list:-1" -- Add padding for lists when 'wrap' is on

if vim.fn.has "nvim-0.9" == 1 then
  vim.o.shortmess = "CFOSWaco" -- Don't show "Scanning..." messages
  vim.o.splitkeep = "screen" -- Reduce scroll during window split
end

if vim.fn.has "nvim-0.10" == 0 then
  vim.o.termguicolors = true -- Enable gui colors (Neovim>=0.10 does this automatically)
end

-- Colors =====================================================================
vim.cmd "colorscheme tokyonight"
-- Enable syntax highlighing if it wasn't already (as it is time consuming)
-- Don't use defer it because it affects start screen appearance
if vim.fn.exists "syntax_on" ~= 1 then
  vim.cmd "syntax enable"
end

-- Editing ====================================================================
vim.o.autoindent = true -- Use auto indent
vim.o.expandtab = true -- Convert tabs to spaces
vim.o.formatoptions = "rqnl1j" -- Improve comment editing
vim.o.ignorecase = true -- Ignore case when searching (use `\C` to force not doing that)
vim.o.incsearch = true -- Show search results while typing
vim.o.infercase = true -- Infer letter cases for a richer built-in keyword completion
vim.o.shiftwidth = 2 -- Use this number of spaces for indentation
vim.o.smartcase = true -- Don't ignore case when searching if pattern has upper case
vim.o.smartindent = true -- Make indenting smart
vim.o.tabstop = 2 -- Insert 2 spaces for a tab
vim.o.virtualedit = "block" -- Allow going past the end of line in visual block mode

vim.o.iskeyword = "@,48-57,_,192-255,-" -- Treat dash separated words as a word text object

-- Define pattern for a start of 'numbered' list. This is responsible for
-- correct formatting of lists when using `gw`. This basically reads as 'at
-- least one special character (digit, -, +, *) possibly followed some
-- punctuation (. or `)`) followed by at least one space is a start of list
-- item'
vim.o.formatlistpat = [[^\s*[0-9\-\+\*]\+[\.\)]*\s\+]]

vim.o.completeopt = "menuone,noselect" -- Show popup even with one item and don't autoselect first
if vim.fn.has "nvim-0.11" == 1 then
  vim.o.completeopt = "menuone,noselect,fuzzy" -- Use fuzzy matching for built-in completion
end
vim.o.complete = ".,w,b,kspell" -- Use spell check and don't use tags for completion

-- Spelling ===================================================================
vim.o.spelllang = "en,ru,uk" -- Define spelling dictionaries
vim.o.spelloptions = "camel" -- Treat parts of camelCase words as seprate words

vim.o.dictionary = vim.fn.stdpath "config" .. "/misc/dict/english.txt" -- Use specific dictionaries

-- Keyboard layout ============================================================
-- Cyrillic keyboard layout
-- stylua: ignore
local langmap_keys = {
  'ёЁ;`~', '№;#',
  'йЙ;qQ', 'цЦ;wW', 'уУ;eE', 'кК;rR', 'еЕ;tT', 'нН;yY', 'гГ;uU', 'шШ;iI', 'щЩ;oO', 'зЗ;pP', 'хХ;[{', 'ъЪ;]}',
  'фФ;aA', 'ыЫ;sS', 'вВ;dD', 'аА;fF', 'пП;gG', 'рР;hH', 'оО;jJ', 'лЛ;kK', 'дД;lL', [[жЖ;\;:]], [[эЭ;'\"]],
  'яЯ;zZ', 'чЧ;xX', 'сС;cC', 'мМ;vV', 'иИ;bB', 'тТ;nN', 'ьЬ;mM', [[бБ;\,<]], 'юЮ;.>',
}
vim.o.langmap = table.concat(langmap_keys, ",")

-- Folds ======================================================================
-- vim.o.foldmethod = "indent" -- Set 'indent' folding method
vim.o.foldmethod = "manual"
vim.o.foldlevel = 1 -- Display all folds except top ones
vim.o.foldnestmax = 10 -- Create folds only for some number of nested levels
vim.g.markdown_folding = 1 -- Use folding by heading in markdown files

if vim.fn.has "nvim-0.10" == 1 then
  vim.o.foldtext = "" -- Use underlying text with its highlighting
end

-- Custom autocommands ========================================================
local augroup = vim.api.nvim_create_augroup("CustomSettings", {})
vim.api.nvim_create_autocmd("FileType", {
  group = augroup,
  callback = function()
    -- Don't auto-wrap comments and don't insert comment leader after hitting 'o'
    -- If don't do this on `FileType`, this keeps reappearing due to being set in
    -- filetype plugins.
    vim.cmd "setlocal formatoptions-=c formatoptions-=o"
  end,
  desc = [[Ensure proper 'formatoptions']],
})

-- Diagnostics ================================================================
local diagnostic_opts = {
  severity_sort = true,
  float = { border = "rounded", source = "if_many" },
  -- float = { border = 'double' },
  -- Show gutter sings
  -- signs = {
  --   -- With highest priority
  --   priority = 9999,
  --   -- Only for warnings and errors
  --   -- severity = { min = 'WARN', max = 'ERROR' },
  --   severity = true,
  -- },
  -- Show virtual text only for errors
  -- virtual_text = { severity = { min = 'ERROR', max = 'ERROR' } },
  -- virtual_text = true,
  jump = { float = true },
  virtual_text = {
    source = "if_many",
    spacing = 2,
    format = function(diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
  },
  -- Don't update diagnostics when typing
  update_in_insert = false,
}

vim.diagnostic.config(diagnostic_opts)

-- -- TODO: clean-up previous options
-- local opt = vim.opt
-- -- Better replace
-- opt.inccommand = "split"
-- -- Set highlight on search
-- opt.hlsearch = true
-- -- Better search
-- opt.ignorecase = true -- Case insensitive search UNLESS /C or capital letter in search
-- opt.smartcase = true
-- -- Better indentation
-- opt.autoindent = true
-- opt.smartindent = true
-- -- opt.showbreak = string.rep(" ", 3) -- Make it so that long lines wrap smartly
-- vim.o.statuscolumn = ""
--
-- opt.formatoptions:remove "o"
-- -- Living on the edge -> or maybe not
-- opt.swapfile = false
-- -- Shorter updatetime
-- opt.updatetime = 250

-- opt.timeoutlen = 300
-- opt.title = true
-- -- -- Floating completion window -> command line
-- -- opt.pumblend = 10
-- -- opt.wildmode = "longest:full,full"
-- -- opt.wildoptions = "pum"
-- --
-- -- -- Command Bar
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
-- -- opt.termguicolors = true
-- -- opt.scrollback = 100000
-- -- opt.scrolloff = 8
-- -- opt.colorcolumn = "80"
-- -- opt.splitkeep = "screen"
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
