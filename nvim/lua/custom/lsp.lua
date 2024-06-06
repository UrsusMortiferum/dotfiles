require("neodev").setup({})

local capabilities = nil
if pcall(require, "cmp_nvim_lsp") then
  capabilities = require("cmp_nvim_lsp").default_capabilities()
end

local lspconfig = require("lspconfig")
local conform = require("conform")

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
  -- pyright = {},
  ruff_lsp = {},
  texlab = {},
}

local servers_to_install = vim.tbl_filter(function(key)
  local t = servers[key]
  if type(t) == "table" then
    return not t.manual_install
  else
    return t
  end
end, vim.tbl_keys(servers))

require("mason").setup()
local ensure_installed = {
  "ruff",
  "mypy",
  "stylua",
  "isort",
  "black",
  -- "codespell",
  "lemminx",
  "xmlformatter",
  "shfmt",
  -- TODO: Add formatter for LaTeX
}

vim.list_extend(ensure_installed, servers_to_install)
require("mason-tool-installer").setup({ ensure_installed = ensure_installed, auto_update = true })

for name, config in pairs(servers) do
  if config == true then
    config = {}
  end
  config = vim.tbl_deep_extend("force", {
    capabilities = capabilities,
  }, config)
  lspconfig[name].setup(config)
end

vim.api.nvim_create_autocmd("User", {
  pattern = "MasonToolsStartingInstall",
  callback = function()
    vim.schedule(function()
      print("mason-tool-installer is starting")
    end)
  end,
})
vim.api.nvim_create_autocmd("User", {
  pattern = "MasonToolsUpdatedCompleted",
  callback = function(e)
    vim.schedule(function()
      print(vim.inspect(e.data))
    end)
  end,
})

local disable_semantic_tokes = {
  lua = true,
}

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

    vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0, desc = "[G]oto [D]definition" })
    vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = 0, desc = "[G]oto [R]eferences" })
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0, desc = "[G]oto [D]eclaration" })
    vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0, desc = "[G]oto [T]ype [D]definition" })
    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0, desc = "Hover Documentation" })

    vim.keymap.set("n", "<spacer>cr", vim.lsp.buf.rename, { buffer = 0, desc = "[C]ode [R]ename" })
    vim.keymap.set("n", "<spacer>ca", vim.lsp.buf.code_action, { buffer = 0, desc = "[C]ode [A]ction" })

    -- TODO: do I need this?
    -- nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
    -- nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]symbols")
    -- nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]symbols")
    -- nmap("<c-k>", vim.lsp.buf.signature_help, "Signature Documentation")

    local filetype = vim.bo[bufnr].filetype
    if disable_semantic_tokes[filetype] then
      client.server_capabilities.semanticTokensProvider = nil
    end
  end,
})

conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = function(bufnr)
      if conform.get_formatter_info("ruff_format", bufnr).available then
        return { "ruff_format" }
      else
        return { "isort", "black", "mypy" }
      end
    end,
    xml = { "xmlformatter" },
    -- ["*"] = { "codespell" },
    fish = { "fish_indent" },
    bash = { "shfmt" },
    zsh = { "shfmt" },
  },
  -- format_on_save = {
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
})

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = function(args)
    conform.format({
      bufnr = args.buf,
      lsp_fallback = true,
      quiet = true,
    })
  end,
})

vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  conform.format({ async = true, lsp_fallback = true, range = range })
end, { range = true })

require("inc_rename").setup()
vim.keymap.set("n", "<leader>rn", function()
  return ":IncRename " .. vim.fn.expand("<cword>")
end, { expr = true, desc = "[R]e[n]ame with Inc Rename" })
