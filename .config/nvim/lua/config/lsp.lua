local lspconfig = require "lspconfig"
local mason_lspconfig = require "mason-lspconfig"
local mason_installer = require "mason-tool-installer"

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(args)
    local map = function(lhs, rhs, desc, mode)
      mode = mode or "n"
      vim.keymap.set(mode, lhs, rhs, { buffer = args.buf, desc = "LSP: " .. desc })
    end
    local diagnostic_jump = function(next, severity)
      local opts = {
        count = next and 1 or -1,
        -- severity = severity,
      }
      -- if severity then
      --   opts.severity = vim.diagnostic.severity[severity]
      -- end
      return function()
        vim.diagnostic.jump(opts)
      end
    end

    map("<leader>lr", vim.lsp.buf.rename, "Rename")
    map("<leader>la", vim.lsp.buf.code_action, "Actions")
    map("<leader>ld", vim.diagnostic.open_float, "Diagnostics popup")
    map("gd", vim.lsp.buf.definition, "Goto Definition")
    map("gr", vim.lsp.buf.references, "Goto References")
    map("gD", vim.lsp.buf.declaration, "Goto Declaration")
    map("gI", vim.lsp.buf.implementation, "Goto implementation")
    map("K", vim.lsp.buf.hover, "Hover")
    map("]d", function()
      vim.diagnostic.jump { count = 1 }
    end, "Next Diagnostics")
    map("[d", function()
      vim.diagnostic.jump { count = -1 }
    end, "Previous Diagnostics")
    map("]e", function()
      vim.diagnostic.jump { count = 1, severity = "ERROR" }
    end, "Next Error")
    map("[e", function()
      vim.diagnostic.jump { count = -1, severity = "ERROR" }
    end, "Previous Error")
    map("]w", function()
      vim.diagnostic.jump { count = 1, severity = "WARN" }
    end, "Next Warning")
    map("[w", function()
      vim.diagnostic.jump { count = -1, severity = "WARN" }
    end, "Previous Warning")

    -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
    ---@param client vim.lsp.Client
    ---@param method vim.lsp.protocol.Method
    ---@param bufnr? integer some lsp support methods only in specific files
    ---@return boolean
    local function client_supports_method(client, method, bufnr)
      return client:supports_method(method, bufnr)
    end

    -- The following two autocommands are used to highlight references of the
    -- word under your cursor when your cursor rests there for a little while.
    --    See `:help CursorHold` for information about when this is executed
    --
    -- When you move your cursor, the highlights will be cleared (the second autocommand).
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, args.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = args.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = args.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })

      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
        callback = function(args2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = "lsp-highlight", buffer = args2.buf }
        end,
      })
    end
  end,
})

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
  basedpyright = { settings = { basedpyright = { analysis = { typeCheckingMode = "standard" } } } },
  -- pyright = {},
  -- pylyzer = {},
  ruff = {},
  sqls = {},
  -- pylsp = {
  --   settings = {
  --     pylsp = {
  --       plugins = {
  --         pyflakes = { enabled = false },
  --         pycodestyle = { enabled = false },
  --         autopep8 = { enabled = false },
  --         yapf = { enabled = false },
  --         mccabe = { enabled = false },
  --         pylsp_mypy = { enabled = false },
  --         pylsp_black = { enabled = false },
  --         pylsp_isort = { enabled = false },
  --       },
  --     },
  -- },
  -- },
  qmlls = {},
  hyprls = {},
  nil_ls = {},
}

local ensure_installed = {
  "stylua",
  "ruff",
  "shfmt",
  "sleek",
  "nixfmt",
}

local servers_to_install = vim.tbl_filter(function(key)
  local t = servers[key]
  if type(t) == "table" then
    return not t.manual_install
  else
    return t
  end
end, vim.tbl_keys(servers))

vim.list_extend(ensure_installed, servers_to_install)
mason_installer.setup { ensure_installed = ensure_installed }

mason_lspconfig.setup {
  ensure_installed = {},
  automatic_installation = false,
  handlers = {
    function()
      for name, config in pairs(servers) do
        if config == true then
          config = {}
        end
        local capabilities = vim.lsp.protocol.make_client_capabilities()
        config = vim.tbl_deep_extend("force", {}, { capabilities = capabilities }, config)
        -- config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
        lspconfig[name].setup(config)
      end
    end,
  },
}
