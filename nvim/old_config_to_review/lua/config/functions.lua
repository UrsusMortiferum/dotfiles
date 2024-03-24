function ListToSQLString()
    local s_line, e_line = vim.fn.line("'<"), vim.fn.line("'>")
    local lines = vim.api.nvim_buf_get_lines(0, s_line - 1, e_line, false)

    local flines = {}
    for _, line in ipairs(lines) do
        table.insert(flines, "'" .. line .. "'")
    end

    local fstring = "(" .. table.concat(flines, ", ") .. ")"
    vim.api.nvim_buf_set_lines(0, s_line - 1, e_line, false, { fstring })
end

vim.api.nvim_set_keymap("v", "<leader>b", ":lua ListToSQLString()<CR>", { noremap = true, silent = true })
