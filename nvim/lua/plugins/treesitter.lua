return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    -- lazy = false,
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = { "c",
        "lua",
        "vim", "vimdoc", "query", "markdown", "markdown_inline",
        "python", "sql",},
        auto_install = true,
        -- ignore_install = { "javascript" },
        highlight = {
          enable = true,
          -- disable = { "c", "rust" },
          disable = function(lang, buf)
              local max_filesize = 100 * 1024 -- 100 KB
              local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
              if ok and stats and stats.size > max_filesize then
                  return true
              end
          end,
          additional_vim_regex_highlighting = false,
        },
      }
      -- require "config.treesitter"
    end,
  },
}
