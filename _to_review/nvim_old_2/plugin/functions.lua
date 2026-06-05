local M = {}

Config.log = {}

-- Create listed scratch buffer and focus on it
Config.new_scratch_buffer = function()
  vim.api.nvim_win_set_buf(0, vim.api.nvim_create_buf(true, true))
end

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
