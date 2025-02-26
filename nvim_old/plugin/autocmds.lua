local function augroup(name)
  return vim.api.nvim_create_augroup("um_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("check_time"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_location"),
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- TODO: Test this autocmd - whether it's needed
-- vim.api.nvim_create_autocmd({ "FileType" }, {
-- 	group = augroup("json_conceal"),
-- 	pattern = { "json", "jsonc", "json5" },
-- 	callback = function()
-- 		vim.opt_local.conceallevel = 0
-- 	end,
-- })

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

vim.api.nvim_create_autocmd({ "BufRead" }, {
  pattern = { "*.conf" },
  callback = function()
    vim.cmd("set filetype=sh")
  end,
})

vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
  pattern = { "tmux-buffer-*" },
  callback = function()
    vim.cmd("! rm %")
  end,
})

-- vim.api.nvim_create_autocmd({ "VimEnter" }, {
--   group = augroup("lualine_clear_hl"),
--   callback = function()
--     local highlight_output = vim.api.nvim_exec(":highlight", true)
--     for line in highlight_output:gmatch("[^\n]+") do
--       if line:find("^lualine_c") or line:find("^lualine_x") then
--         local key = line:match("^([^%s]+)")
--         vim.cmd("highlight " .. key .. " guibg=NONE ctermbg=NONE blend=0")
--         print(key)
--       end
--     end
--   end,
-- })

--vim.cmd([[
--augroup AutoOrderBuffers
--    autocmd!
--    autocmd BufWinEnter * :BufferOrderByLanguage
--    autocmd BufWinLeave * :BufferOrderByLanguage
--augroup END
--]])
