return {
  {
    -- TODO: Move token somewhere else to not store in the repo
    "YannickFricke/codestats.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      token = "SFMyNTY.VlhKemRYTmZUVzl5ZEdsbVpYSjFiUT09IyNNakEwT0RRPQ.4Eg9Lr8VH94F9SP1Ul7IYGnMEr-fdKfxw1kZjvEmey8",
    },
  },
  {
    "folke/todo-comments.nvim",
    cmd = { "TodoTrouble", "TodoTelescope" },
    event = "LazyFile",
    config = true,
    keys = {
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "Previous [T]odo Comment",
      },
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "Next [T]odo Comment",
      },
      { "<leader>td", "<cmd>TodoTrouble<cr>", desc = "Todo [T]rouble List" },
    },
  },
  { "numToStr/Comment.nvim", event = "VeryLazy", opts = { { ignore = "^$" } } },
  {
    "mbbill/undotree",
    keys = { { "<leader>u", vim.cmd.UndotreeToggle, desc = "Launch [U]ndo Tree" } },
  },
  {
    "folke/trouble.nvim",
    cmd = { "TroubleToggle", "Trouble" },
    opts = { use_diagnostic_signs = true },
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      {
        "<leader>qf",
        "<cmd>TroubleToggle workspace_diagnostics<cr>",
        desc = "Toggle Trouble [Q]uick[F]ix List",
      },
      {
        "[q",
        function()
          if require("trouble").is_open() then
            require("trouble").previous({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cprev)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Previous trouble/quickfix item",
      },
      {
        "]q",
        function()
          if require("trouble").is_open() then
            require("trouble").next({ skip_groups = true, jump = true })
          else
            local ok, err = pcall(vim.cmd.cnext)
            if not ok then
              vim.notify(err, vim.log.levels.ERROR)
            end
          end
        end,
        desc = "Next trouble/quickfix item",
      },
    },
  },
  {
    "monaqa/dial.nvim",
    keys = {
      {
        "<c-a>",
        function()
          return require("dial.map").inc_normal()
        end,
        expr = true,
        desc = "Increment",
      },
      {
        "<c-x>",
        function()
          return require("dial.map").dec_normal()
        end,
        expr = true,
        desc = "Decrement",
      },
    },
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.date.alias["%Y-%m-%d"],
          augend.date.alias["%m/%d"],
          augend.date.alias["%H:%M"],
          augend.constant.alias.bool,
          augend.semver.alias.semver,
        },
      })
    end,
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    depends_on = { "nvim-lua/plenary.nvim" },
    opts = { save_on_toggle = true, sync_on_ui_close = true },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup({})
      local map = function(keys, func, desc)
        vim.keymap.set("n", keys, func, { desc = "[H]arpoon " .. desc })
      end
      map("<leader>a", function()
        harpoon:list():append()
      end, "Add File")
      map("<leader>h", function()
        harpoon.ui:toggle_quick_menu(
          harpoon:list(),
          { border = "rounded", title_pos = "center", ui_width_ratio = 0.50 }
        )
      end, "File Menu")
      -- call nvim_win_set_option(win, 'winhighlight',)
      -- vim.api.nvim_create_autocmd({ "FileType" }, {
      --   pattern = "harpoon",
      --   callback = function()
      -- vim.opt.winblend = 10 -- 0 ~ 100
      -- vim.opt.cursorline = true
      -- vim.api.nvim_set_hl(0,'HarpoonWindow', {link = 'Normal'})
      -- vim.api.nvim_set_hl(0,'HarpoonBorder', {link = 'Normal'})
      vim.cmd([[
      highlight HarpoonCurrentFile guibg=NONE ctermbg=NONE blend=0
      ]])
      --   end,
      -- })
    end,
    -- local harpoon = require("harpoon")
    --
    -- harpoon:setup()
    --
    -- vim.keymap.set("n", "<leader>

    -- options = { global_settings = { save_on_toggle = true, enter_on_sendcmd = true } },
    -- keys = {
    --   {
    --     "<leader>a",
    --     function()
    --       require("harpoon.mark").add_file()
    --     end,
    --     desc = "[H] Add File",
    --   },
    --   {
    --     "<leader>h",
    --     function()
    --       require("harpoon.ui").toggle_quick_menu()
    --     end,
    --     desc = "[H] File Menu",
    --   },
    --   {
    --     "<leader>1",
    --     function()
    --       require("harpoon.ui").nav_file(1)
    --     end,
    --     desc = "[H] File 1",
    --   },
    --   {
    --     "<leader>2",
    --     function()
    --       require("harpoon.ui").nav_file(2)
    --     end,
    --     desc = "[H] File 2",
    --   },
    --   {
    --     "<leader>3",
    --     function()
    --       require("harpoon.ui").nav_file(3)
    --     end,
    --     desc = "[H] File 3",
    --   },
    --   {
    --     "<leader>4",
    --     function()
    --       require("harpoon.ui").nav_file(4)
    --     end,
    --     desc = "[H] File 4",
    --   },
    --   {
    --     "<leader>hc",
    --     function()
    --       require("harpoon.cmd-ui").toggle_quick_menu()
    --     end,
    --     desc = "[H] Terminal Menu",
    --   },
    --   {
    --     "<leader>h1",
    --     function()
    --       require("harpoon.term").gotoTerminal(1)
    --     end,
    --     desc = "[H] Terminal 1",
    --   },
    --   {
    --     "<leader>h2",
    --     function()
    --       require("harpoon.term").gotoTerminal(2)
    --     end,
    --     desc = "[H] Terminal 2",
    --   },
    --   {
    --     "<leader>h3",
    --     function()
    --       require("harpoon.term").gotoTerminal(3)
    --     end,
    --     desc = "[H] Terminal 3",
    --   },
    --   {
    --     "<leader>h4",
    --     function()
    --       require("harpoon.term").gotoTerminal(4)
    --     end,
    --     desc = "[H] Terminal 4",
    --   },
    -- },
  },
}
