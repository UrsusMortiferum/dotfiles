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

function PythonExecuteSelection()
  local lines = vim.api.nvim_buf_get_lines(0, vim.fn.line("'<") - 1, vim.fn.line("'>"), false)
  local code = table.concat(lines, "\n")
  print(code)

  local command = "python -c " .. vim.fn.shellescape(code)
  -- print(command)

  local handle = vim.fn.systemlist(command)
  for _, line in ipairs(handle) do
    print(line)
  end
end
