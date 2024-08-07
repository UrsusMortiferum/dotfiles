local icons = require("custom.utils").icons

return {
  { "nvim-tree/nvim-web-devicons", lazy = true },
  { "MunifTanjim/nui.nvim", lazy = true },
  { "nvim-lua/plenary.nvim", lazy = true },
  {
    "anuvyklack/windows.nvim", -- auto-resize windows
    event = "WinNew",
    dependencies = { { "anuvyklack/middleclass" }, { "anuvyklack/animation.nvim", enabled = false } },
    keys = { { "<leader>z", "<cmd>WindowsMaximize<cr>", desc = "Toggle window zoom" } },
    config = function()
      vim.o.winwidth = 20
      vim.o.equalalways = false
      require("windows").setup({
        animation = { enable = false, duration = 150 },
      })
    end,
  },
  -- {
  --   "folke/noice.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     -- add any options here
  --   },
  --   dependencies = {
  --     -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
  --     "MunifTanjim/nui.nvim",
  --     -- OPTIONAL:
  --     --   `nvim-notify` is only needed, if you want to use the notification view.
  --     --   If not available, we use `mini` as the fallback
  --     -- "rcarriga/nvim-notify",
  --   },
  --   config = function()
  --     require("noice").setup({
  --       lsp = {
  --         -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
  --         override = {
  --           ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
  --           ["vim.lsp.util.stylize_markdown"] = true,
  --           ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
  --         },
  --         progress = { enabled = false },
  --       },
  --       presets = {
  --         command_palette = true, -- position the cmdline and popupmenu together
  --         long_message_to_split = true, -- long messages will be sent to a split
  --         inc_rename = true, -- enables an input dialog for inc-rename.nvim
  --         lsp_doc_border = true, -- add a border to hover docs and signature help
  --       },
  --       views = {
  --         split = {
  --           enter = true,
  --         },
  --       },
  --     })
  --   end,
  -- },
  {
    "nvim-lualine/lualine.nvim",
    -- init = function()
    --   vim.g.lualine_laststatus = vim.o.laststatus
    --   if vim.fn.argc(-1) > 0 then
    --     -- set an empty statusline till lualine loads
    --     vim.o.statusline = " "
    --   else
    --     -- hide the statusline on the starter page
    --     vim.o.laststatus = 0
    --   end
    -- end,
    event = "VeryLazy",
    opts = function()
      local lualine_require = require("lualine_require")
      lualine_require.require = require
      vim.o.laststatus = vim.g.lualine_laststatus

      return {
        options = {
          component_separators = icons.misc.light_bar,
          theme = "auto",
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "alpha" } },
        },
        sections = {
          lualine_a = {
            { "mode", icon = "", separator = { left = icons.misc.moon_last_quarter }, right_padding = 2 },
          },
          lualine_b = {
            { "branch", icon = "", separator = { right = icons.misc.moon_first_quarter }, left_padding = 2 },
          },
          lualine_c = {
            {
              "diagnostics",
              symbols = {
                error = " ",
                warn = " ",
                info = " ",
                hint = "󰝶 ",
              },
            },
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
            { "filename", padding = { left = 1, right = 0 } },
            -- {
            --   function()
            --     local buffer_count = require("core.utils").get_buffer_count()
            --
            --     return "+" .. buffer_count - 1 .. " "
            --   end,
            --   cond = function()
            --     return require("core.utils").get_buffer_count() > 1
            --   end,
            --   -- color = utils.get_hlgroup("Operator", nil),
            --   padding = { left = 0, right = 1 },
            -- },
            -- {
            --   "diff",
            --   symbols = {
            --     added = icons.git.added,
            --     modified = icons.git.modified,
            --     removed = icons.git.removed,
            --   },
            --   source = function()
            --     local gitsigns = vim.b.gitsigns_status_dict
            --     if gitsigns then
            --       return {
            --         added = gitsigns.added,
            --         modified = gitsigns.changed,
            --         removed = gitsigns.removed,
            --       }
            --     end
            --   end,
            -- },
            { "buffers" },
          },
          lualine_x = {
            {
              "diagnostics",
              symbols = {
                error = icons.diagnostics.Error,
                warn = icons.diagnostics.Warn,
                info = icons.diagnostics.Info,
                hint = icons.diagnostics.Hint,
              },
              sources = { "nvim_diagnostic", "coc", "nvim_lsp" },
              sections = { "error", "warn", "info", "hint" },
              colored = true, -- Displays diagnostics status in color if set to true.
              update_in_insert = false, -- Update diagnostics in insert mode.
              always_visible = false, -- Show diagnostics even if there are none.
            },
            { "%f" },
            {
              function()
                if vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] == nil then
                  return icons.misc.fallen_leaf .. " No TS"
                else
                  return icons.misc.tree
                end
              end,
            },
            {
              function()
                local message = "No LSP"
                local buffer_id = vim.api.nvim_get_current_buf()
                local clients = vim.lsp.get_clients({ bufnr = buffer_id })
                local clients_names = {}
                local icon =
                  require("nvim-web-devicons").get_icon(vim.fn.expand("%:t"), vim.fn.expand("%:e"), { default = true })
                if next(clients) == nil then
                  return message
                else
                  for _, client in ipairs(clients) do
                    table.insert(clients_names, client.name)
                  end
                  return icon .. " :" .. table.concat(clients_names, ", ")
                end
              end,
            },
          },
          lualine_y = { { "location", separator = { left = icons.misc.moon_last_quarter }, right_padding = 2 } },
          lualine_z = {
            {
              function()
                return icons.misc.clock .. " " .. os.date("%H:%M:%S")
              end,
              separator = { right = icons.misc.moon_first_quarter },
              left_padding = 2,
            },
          },
        },

        extensions = { "lazy", "toggleterm", "mason", "neo-tree", "trouble" },
      }
    end,
  },
}
