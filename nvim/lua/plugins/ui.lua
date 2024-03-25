-- TODO: once welcome plugin is establish, use this as a logo if not, figure out a way to apply it without plugin
-- local apple = {
-- 	[[                    'c.]],
-- 	[[                 ,xNMM.]],
-- 	[[               .OMMMM]],
-- 	[[              OMMM0]],
-- 	[[    .;loddo:' loolloddol;.     ████████╗██╗  ██╗██╗███╗   ██╗██╗  ██╗]],
-- 	[[   cKMMMMMMMMMMNWMMMMMMMMMM0:  ╚══██╔══╝██║  ██║██║████╗  ██║██║ ██╔╝]],
-- 	[[ .KMMMMMMMMMMMMMMMMMMMMMMMWd.     ██║   ███████║██║██╔██╗ ██║█████╔╝]],
-- 	[[ XMMMMMMMMMMMMMMMMMMMMMMMX.       ██║   ██╔══██║██║██║╚██╗██║██╔═██╗]],
-- 	[[;MMMMMMMMMMMMMMMMMMMMMMMM:        ██║   ██║  ██║██║██║ ╚████║██║  ██╗]],
-- 	[[:MMMMMMMMMMMMMMMMMMMMMMMM:        ╚═╝   ╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝]],
-- 	[[.MMMMMMMMMMMMMMMMMMMMMMMMX.    ██████╗ ██╗███████╗███████╗███████╗██████╗ ███████╗███╗   ██╗████████╗]],
-- 	[[ kMMMMMMMMMMMMMMMMMMMMMMMMWd.  ██╔══██╗██║██╔════╝██╔════╝██╔════╝██╔══██╗██╔════╝████╗  ██║╚══██╔══╝]],
-- 	[[ .XMMMMMMMMMMMMMMMMMMMMMMMMMMk ██║  ██║██║█████╗  █████╗  █████╗  ██████╔╝█████╗  ██╔██╗ ██║   ██║]],
-- 	[[  .XMMMMMMMMMMMMMMMMMMMMMMMMK. ██║  ██║██║██╔══╝  ██╔══╝  ██╔══╝  ██╔══██╗██╔══╝  ██║╚██╗██║   ██║]],
-- 	[[    kMMMMMMMMMMMMMMMMMMMMMMd   ██████╔╝██║██║     ██║     ███████╗██║  ██║███████╗██║ ╚████║   ██║]],
-- 	[[     ;KMMMMMMMWXXWMMMMMMMk.    ╚═════╝ ╚═╝╚═╝     ╚═╝     ╚══════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═══╝   ╚═╝]],
-- 	[[       .cooc,.    .,coup:.]],
-- }

local icons = require("config.utils").icons

return {
  { "nvim-tree/nvim-web-devicons", lazy = true },
  { "MunifTanjim/nui.nvim", lazy = true },
  { "nvim-lua/plenary.nvim", lazy = true },
  -- auto-resize windows
  {
    "anuvyklack/windows.nvim",
    event = "WinNew",
    dependencies = { { "anuvyklack/middleclass" }, { "anuvyklack/animation.nvim", enabled = false } },
    keys = { { "<leader>m", "<cmd>WindowsMaximize<cr>", desc = "maximize window" } },
    config = function()
      vim.o.winwidth = 20
      vim.o.equalalways = false
      require("windows").setup({
        animation = { enable = false, duration = 150 },
      })
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    name = "tokyonight",
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        transparent = true,
        styles = {
          comments = { italic = false },
          keywords = { italic = false },
        },
      })
      vim.cmd([[colorscheme tokyonight-night]])
    end,
  },
  {
    -- TODO: make it beautiful and useful if not -> let's get rid of it
    "lukas-reineke/indent-blankline.nvim",
    event = "LazyFile",
    opts = {
      indent = { char = "|", tab_char = "|" },
      scope = { enabled = false },
      exclude = {
        filetypes = { "help", "Trouble", "trouble", "lazy", "mason" },
      },
    },
    main = "ibl",
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      -- "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
          progress = { enabled = false },
        },
        presets = {
          command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = true, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = true, -- add a border to hover docs and signature help
        },
        views = {
          split = {
            enter = true,
          },
        },
      })
    end,
  },
  -- TODO: check later mini + statusline plugin from tj -> express line
  -- Finalize current setup - buffers + final review
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    -- lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    opts = function()
      local lualine_require = require("lualine_require")
      lualine_require.require = require
      vim.o.laststatus = vim.g.lualine_laststatus

      return {
        options = {
          theme = "auto",
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "lazy" } },
          component_separators = icons.misc.light_bar,
          -- section_separators = { left = "", right = "" },
          -- component_separators = { left = "", right = "" },
          -- section_separators = { left = "", right = "" },
          -- section_separators = { left = "", right = "" },
          -- component_separators = { left = "", right = "" },
        },
        sections = {
          lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
          lualine_b = { { "branch", separator = { right = "" }, left_padding = 2 } },
          lualine_c = {
            {
              "diff",
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                removed = icons.git.removed,
              },
              source = function()
                local gitsigns = vim.b.gitsigns_status_dict
                if gitsigns then
                  return {
                    added = gitsigns.added,
                    modified = gitsigns.changed,
                    removed = gitsigns.removed,
                  }
                end
              end,
            },
            "buffers",
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
              -- Table of diagnostic sources, available sources are:
              --   "nvim_lsp", "nvim_diagnostic", "nvim_workspace_diagnostic", "coc", "ale", "vim_lsp'.
              sources = { "nvim_diagnostic", "coc", "nvim_lsp" },
              -- or a function that returns a table as such:
              --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
              sections = { "error", "warn", "info", "hint" },
              colored = true, -- Displays diagnostics status in color if set to true.
              update_in_insert = false, -- Update diagnostics in insert mode.
              always_visible = false, -- Show diagnostics even if there are none.
            },
            {
              "filename",
              file_status = true, -- Displays file status (readonly status, modified status)
              newfile_status = false, -- Display new file status (new file means no write after created)
              path = 4, -- 0: Just the filename
              -- 1: Relative path
              -- 2: Absolute path
              -- 3: Absolute path, with tilde as the home directory
              -- 4: Filename and parent dir, with tilde as the home directory
              symbols = {
                modified = "[+]", -- Text to show when the file is modified.
                readonly = "[-]", -- Text to show when the file is non-modifiable or readonly.
                unnamed = "[No Name]", -- Text to show for unnamed buffers.
                newfile = "[New]", -- Text to show for newly created file before first write
              },
            },
            -- {
            --   "buffers",
            --   show_filename_only = true, -- Shows shortened relative path when set to false.
            --   hide_filename_extension = false, -- Hide filename extension when set to true.
            --   show_modified_status = true, -- Shows indicator when the buffer is modified.
            --
            --   mode = 0, -- 0: Shows buffer name
            --   -- 1: Shows buffer index
            --   -- 2: Shows buffer name + buffer index
            --   -- 3: Shows buffer number
            --   -- 4: Shows buffer name + buffer number
            --
            --   max_length = vim.o.columns * 2 / 3, -- Maximum width of buffers component,
            --   -- it can also be a function that returns
            --   -- the value of `max_length` dynamically.
            --   filetype_names = {
            --     TelescopePrompt = "Telescope",
            --     dashboard = "Dashboard",
            --     packer = "Packer",
            --     fzf = "FZF",
            --     alpha = "Alpha",
            --   }, -- Shows specific buffer name for that filetype ( { `filetype` = `buffer_name`, ... } )
            --
            --   -- Automatically updates active buffer color to match color of other components (will be overridden if buffers_color is set)
            --   use_mode_colors = false,
            --
            --   buffers_color = {
            --     -- Same values as the general color option can be used here.
            --     active = "lualine_{section}_normal", -- Color for active buffer.
            --     inactive = "lualine_{section}_inactive", -- Color for inactive buffer.
            --   },
            --
            --   symbols = {
            --     modified = " ●", -- Text to show when the buffer is modified
            --     alternate_file = "#", -- Text to show to identify the alternate file
            --     directory = "", -- Text to show when the buffer is a directory
            --   },
            -- },
            {
              function()
                local message = "No Treesitter"
                if vim.treesitter.highlighter.active[vim.api.nvim_get_current_buf()] == nil then
                  return message
                else
                  return "🌳 Active TS"
                end
              end,
            },
            {
              function()
                local message = "No Active LSP"
                local buffer_id = vim.api.nvim_get_current_buf()
                local clients = vim.lsp.get_active_clients({ bufnr = buffer_id })
                local clients_names = {}
                local icon =
                  require("nvim-web-devicons").get_icon(vim.fn.expand("%:t"), vim.fn.expand("%:e"), { default = true })
                if next(clients) == nil then
                  return message
                else
                  for _, client in ipairs(clients) do
                    table.insert(clients_names, client.name)
                  end
                  return icon .. " LSP: " .. table.concat(clients_names, ", ")
                end
              end,
            },
          },
          lualine_y = { { "location", separator = { left = "" }, right_padding = 2 } },
          lualine_z = {
            {
              function()
                return "  " .. os.date("%H:%M:%S")
              end,
              separator = { right = "" },
              left_padding = 2,
            },
          },
        },
      }
    end,
  },
}
