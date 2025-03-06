local conform = require "conform"
local lspconfig = require "lspconfig"
local mason = require "mason"
local mason_lspconfig = require "mason-lspconfig"
local mason_installer = require "mason-tool-installer"

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
  pylsp = {
    settings = {
      pylsp = {
        plugins = {
          pyflakes = { enabled = false },
          pycodestyle = { enabled = false },
          autopep8 = { enabled = false },
          yapf = { enabled = false },
          mccabe = { enabled = false },
          pylsp_mypy = { enabled = false },
          pylsp_black = { enabled = false },
          pylsp_isort = { enabled = false },
        },
      },
    },
  },
}

local ensure_installed = {
  "stylua",
  "ruff",
  "shfmt",
}

local servers_to_install = vim.tbl_filter(function(key)
  local t = servers[key]
  if type(t) == "table" then
    return not t.manual_install
  else
    return t
  end
end, vim.tbl_keys(servers))

mason.setup()
vim.list_extend(ensure_installed, servers_to_install)
mason_installer.setup { ensure_installed = ensure_installed }

for name, config in pairs(servers) do
  if config == true then
    config = {}
  end
  config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
  -- config = vim.tbl_deep_extend("force", {}, { capabilities = capabilities }, config)
  lspconfig[name].setup(config)
end

-- local disable_semantic_tokens = {
--   lua = true,
-- }
--
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(args)
    local function client_supports_method(client, method, bufnr)
      return client:supports_method(method, bufnr)
    end

    -- local bufnr = args.buf
    -- local client = vim.lsp.get_client_by_id(args.data.client_id)
    -- local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

    -- vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
    -- vim.lsp.inlay_hint.enable()
    --
    --     local filetype = vim.bo[bufnr].filetype
    --     if disable_semantic_tokens[filetype] then
    --       client.server_capabilities.semanticTokensProvider = nil
    --     end
  end,
})

conform.setup {
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "ruff" },
    bash = { "shfmt" },
    zsh = { "shfmt" },
  },
}

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(args)
    conform.format { bufnr = args.buf }
  end,
})

-- vim.api.nvim_create_autocmd("LspAttach", {
--   group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
--   callback = function(event)
--     -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
--     ---@param client vim.lsp.Client
--     ---@param method vim.lsp.protocol.Method
--     ---@param bufnr? integer some lsp support methods only in specific files
--     ---@return boolean
--     local function client_supports_method(client, method, bufnr)
--       if vim.fn.has "nvim-0.11" == 1 then
--         return client:supports_method(method, bufnr)
--       else
--         return client.supports_method(method, { bufnr = bufnr })
--       end
--     end
--
--     -- The following two autocommands are used to highlight references of the
--     -- word under your cursor when your cursor rests there for a little while.
--     --    See `:help CursorHold` for information about when this is executed
--     --
--     -- When you move your cursor, the highlights will be cleared (the second autocommand).
--     local client = vim.lsp.get_client_by_id(event.data.client_id)
--     if
--       client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf)
--     then
--       local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
--       vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
--         buffer = event.buf,
--         group = highlight_augroup,
--         callback = vim.lsp.buf.document_highlight,
--       })
--
--       vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
--         buffer = event.buf,
--         group = highlight_augroup,
--         callback = vim.lsp.buf.clear_references,
--       })
--
--       vim.api.nvim_create_autocmd("LspDetach", {
--         group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
--         callback = function(event2)
--           vim.lsp.buf.clear_references()
--           vim.api.nvim_clear_autocmds { group = "kickstart-lsp-highlight", buffer = event2.buf }
--         end,
--       })
--     end
--
--     -- The following code creates a keymap to toggle inlay hints in your
--     -- code, if the language server you are using supports them
--     --
--     -- This may be unwanted, since they displace some of your code
--     -- if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
--     --   map("<leader>th", function()
--     --     vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
--     --   end, "[T]oggle Inlay [H]ints")
--     -- end
--   end,
-- })
--
--   -- Diagnostic Config
--   -- See :help vim.diagnostic.Opts
--   vim.diagnostic.config {
--     severity_sort = true,
--     float = { border = 'rounded', source = 'if_many' },
--     underline = { severity = vim.diagnostic.severity.ERROR },
--     signs = vim.g.have_nerd_font and {
--       text = {
--         [vim.diagnostic.severity.ERROR] = '󰅚 ',
--         [vim.diagnostic.severity.WARN] = '󰀪 ',
--         [vim.diagnostic.severity.INFO] = '󰋽 ',
--         [vim.diagnostic.severity.HINT] = '󰌶 ',
--       },
--     } or {},
--     virtual_text = {
--       source = 'if_many',
--       spacing = 2,
--       format = function(diagnostic)
--         local diagnostic_message = {
--           [vim.diagnostic.severity.ERROR] = diagnostic.message,
--           [vim.diagnostic.severity.WARN] = diagnostic.message,
--           [vim.diagnostic.severity.INFO] = diagnostic.message,
--           [vim.diagnostic.severity.HINT] = diagnostic.message,
--         }
--         return diagnostic_message[diagnostic.severity]
--       end,
--     },
--   }
--
--   -- LSP servers and clients are able to communicate to each other what features they support.
--   --  By default, Neovim doesn't support everything that is in the LSP specification.
--   --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
--   --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
--   local capabilities = vim.lsp.protocol.make_client_capabilities()
--   capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
--
--   -- Enable the following language servers
--   --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--   --
--   --  Add any additional override configuration in the following tables. Available keys are:
--   --  - cmd (table): Override the default command used to start the server
--   --  - filetypes (table): Override the default list of associated filetypes for the server
--   --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
--   --  - settings (table): Override the default settings passed when initializing the server.
--   --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
--   local servers = {
--     -- clangd = {},
--     -- gopls = {},
--     -- pyright = {},
--     -- rust_analyzer = {},
--     -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
--     --
--     -- Some languages (like typescript) have entire language plugins that can be useful:
--     --    https://github.com/pmizio/typescript-tools.nvim
--     --
--     -- But for many setups, the LSP (`ts_ls`) will work just fine
--     -- ts_ls = {},
--     --
--
--     lua_ls = {
--       -- cmd = { ... },
--       -- filetypes = { ... },
--       -- capabilities = {},
--       settings = {
--         Lua = {
--           completion = {
--             callSnippet = 'Replace',
--           },
--           -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
--           -- diagnostics = { disable = { 'missing-fields' } },
--         },
--       },
--     },
--   }
--
--   -- Ensure the servers and tools above are installed
--   --
--   -- To check the current status of installed tools and/or manually install
--   -- other tools, you can run
--   --    :Mason
--   --
--   -- You can press `g?` for help in this menu.
--   --
--   -- `mason` had to be setup earlier: to configure its options see the
--   -- `dependencies` table for `nvim-lspconfig` above.
--   --
--   -- You can add other tools here that you want Mason to install
--   -- for you, so that they are available from within Neovim.
--   local ensure_installed = vim.tbl_keys(servers or {})
--   vim.list_extend(ensure_installed, {
--     'stylua', -- Used to format Lua code
--   })
--   require('mason-tool-installer').setup { ensure_installed = ensure_installed }
--
--   require('mason-lspconfig').setup {
--     ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
--     automatic_installation = false,
--     handlers = {
--       function(server_name)
--         local server = servers[server_name] or {}
--         -- This handles overriding only values explicitly passed
--         -- by the server configuration above. Useful when disabling
--         -- certain features of an LSP (for example, turning off formatting for ts_ls)
--         server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
--         require('lspconfig')[server_name].setup(server)
--       end,
--     },
--   }
-- end,
