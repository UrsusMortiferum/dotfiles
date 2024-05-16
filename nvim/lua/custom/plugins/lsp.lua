return {
  {
    "neovim/nvim-lspconfig",
    event = "LazyFile",
    -- event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      {
        "williamboman/mason.nvim",
        cmd = "Mason",
        keys = { { "<leader>sm", "<cmd>Mason<cr>", desc = "[S]how [M]ason" } },
        build = ":MasonUpdate",
      },
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
      { "folke/neodev.nvim", opts = {} },
      { "j-hui/fidget.nvim", opts = {} },
      {
        "smjonas/inc-rename.nvim",
        opts = {},
        vim.keymap.set("n", "<leader>rn", function()
          return ":IncRename " .. vim.fn.expand("<cword>")
        end, { expr = true, desc = "[R]e[n]ame with Inc Rename" }),

        vim.cmd([[
        highlight NoiceCmdlinePopupBorderIncRename blend=0
        highlight NoiceCmdlineIconIncRename blend=0
        ]]),
      },
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("custom-lsp-attach", { clear = true }),
        callback = function(event)
          local nmap = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
          nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
          nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
          nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
          nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]symbols")
          nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]symbols")
          nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
          nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
          nmap("<leader>ca", function()
            vim.lsp.buf.code_action({ context = { only = { "quickfix", "refactor", "source" } } })
          end, "[C]ode [A]ction")
          nmap("K", vim.lsp.buf.hover, "Hover Documentation")
          nmap("<c-k>", vim.lsp.buf.signature_help, "Signature Documentation")
        end,
      })

      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
              format = {
                enable = true,
                defaultConfig = {
                  indent_style = "space",
                  indent_size = "2",
                  continuation_indent_size = "2",
                },
              },
            },
            -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { 'missing-fields' } },
          },
        },
        pyright = {},
        ruff_lsp = {},
        texlab = {},
      }

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        "ruff",
        "mypy",
        "stylua",
        "isort",
        "black",
        "codespell",
        -- TODO: Add formatter for LaTeX
      })

      require("mason").setup()
      require("mason-tool-installer").setup({ ensure_installed = ensure_installed })
      require("mason-lspconfig").setup({
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            require("lspconfig")[server_name].setup({
              cmd = server.cmd,
              settings = server.settings,
              filetypes = server.filetypes,
              capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {}),
            })
          end,
        },
      })
    end,
  },

  -- TODO: check it later
  -- 		vim.diagnostic.config({
  -- 			-- update_in_insert = true,
  -- 			float = {
  -- 				focusable = false,
  -- 				style = "minimal",
  -- 				border = "rounded",
  -- 				source = "always",
  -- 				header = "",
  -- 				prefix = "",
  -- 			},
  -- 		})
  -- 	end,
  -- },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "[F]ormat with Conform",
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = function(bufnr)
          if require("conform").get_formatter_info("ruff_format", bufnr).available then
            return { "ruff_format" }
          else
            return { "isort", "black", "mypy" }
          end
        end,
        ["*"] = { "codespell" },
      },
      formatters = {},
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },
}

-- -- [[ Configure LSP ]]
-- --  This function gets run when an LSP connects to a particular buffer.
-- local on_attach = function(_, bufnr)
--     -- NOTE: Remember that lua is a real programming language, and as such it is possible
--     -- to define small helper and utility functions so you don't have to repeat yourself
--     -- many times.
--     --
--     -- In this case, we create a function that lets us more easily define mappings specific
--     -- for LSP related items. It sets the mode, buffer and description for us each time.
--     local nmap = function(keys, func, desc)
--         if desc then
--             desc = 'LSP: ' .. desc
--         end
--
--         vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
--     end
--
--     nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
--     nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
--
--     nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
--     nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
--     nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
--     nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
--     nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
--     nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
--
--     -- See `:help K` for why this keymap
--     nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
--     nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
--
--     -- Lesser used LSP functionality
--     nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
--     nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
--     nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
--     nmap('<leader>wl', function()
--         print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--     end, '[W]orkspace [L]ist Folders')
--
--     -- Create a command `:Format` local to the LSP buffer
--     vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
--         vim.lsp.buf.format()
--     end, { desc = 'Format current buffer with LSP' })
-- end
--
-- -- Enable the following language servers
-- --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
-- --
-- --  Add any additional override configuration in the following tables. They will be passed to
-- --  the `settings` field of the server config. You must look up that documentation yourself.
-- local servers = {
--     -- clangd = {},
--     -- gopls = {},
--     pyright = {},
--     -- rust_analyzer = {},
--     -- tsserver = {},
--     -- sqlls = {},
--     lua_ls = {
--         Lua = {
--             workspace = { checkThirdParty = false },
--             telemetry = { enable = false },
--         },
--     },
-- }
--
-- -- Setup neovim lua configuration
-- require('neodev').setup()
--
-- -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
--
-- -- Ensure the servers above are installed
-- local mason_lspconfig = require 'mason-lspconfig'
--
-- mason_lspconfig.setup {
--     ensure_installed = vim.tbl_keys(servers),
-- }
--
-- mason_lspconfig.setup_handlers {
--     function(server_name)
--         require('lspconfig')[server_name].setup {
--             capabilities = capabilities,
--             on_attach = on_attach,
--             settings = servers[server_name],
--         }
--     end,
-- }
