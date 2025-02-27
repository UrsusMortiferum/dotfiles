local M = {}

M.setup = function()
  local group = vim.api.nvim_create_augroup("custom-treesitter", { clear = true })

  require("nvim-treesitter").setup {
    ensure_installed = {
      "core",
      "stable",
      "community",
      -- Elixir langs
      -- "elixir",
      -- "heex",
    },
  }

  local syntax_on = {
    elixir = true,
    php = true,
  }

  vim.api.nvim_create_autocmd("FileType", {
    group = group,
    callback = function(args)
      local bufnr = args.buf
      local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
      if not ok or not parser then
        return
      end
      pcall(vim.treesitter.start)

      local ft = vim.bo[bufnr].filetype
      if syntax_on[ft] then
        vim.bo[bufnr].syntax = "on"
      end
    end,
  })
end

-- M.setup()

return M
