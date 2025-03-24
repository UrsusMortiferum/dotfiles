local M = {}

Config.log = {}

-- Insert section
Config.insert_section = function(symbol, total_width)
  symbol = symbol or "="
  total_width = total_width or 79

  -- Insert template: 'commentstring' but with '%s' replaced by section symbols
  local comment_string = vim.bo.commentstring
  local content = string.rep(symbol, total_width - (comment_string:len() - 2))
  local section_template = comment_string:format(content)
  vim.fn.append(vim.fn.line ".", section_template)

  -- Enable Replace mode in appropriate place
  local inner_start = comment_string:find "%%s"
  vim.fn.cursor(vim.fn.line "." + 1, inner_start)
  vim.cmd [[startreplace]]
end
