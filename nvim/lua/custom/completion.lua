-- require("custom.snippets")

vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append("c")

local lspkind = require("lspkind")
lspkind.init({})

local cmp = require("cmp")

cmp.setup({
  sources = {
    { name = "nvim_lsp" },
    { name = "codeium" },
    { name = "path" },
    { name = "buffer" },
    { name = "luasnip" },
    { name = "emoji" },
    { name = "obsidian" },
  },
  mapping = {
    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<C-y>"] = cmp.mapping(
      cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      }),
      { "i", "c" }
    ),
  },
  snippet = {
    expand = function(args)
      vim.snippet.expand(args.body)
    end,
  },
})

cmp.setup.filetype({ "markdown" }, {
  sources = {
    { name = "obsidian.nvim" },
  },
})

for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/custom/snippets/*.lua", true)) do
  loadfile(ft_path)()
end

-- -- Setup up vim-dadbod
-- cmp.setup.filetype({ "sql" }, {
--   sources = {
--     { name = "vim-dadbod-completion" },
--     { name = "buffer" },
--   },
-- })

local ls = require("luasnip")
ls.config.set_config({
  history = false,
  updateevents = "TextChanged,TextChangedI",
})

vim.keymap.set({ "i", "s" }, "<c-k>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true, desc = "Expand snippet or jump to next placeholder" })

vim.keymap.set({ "i", "s" }, "<c-j>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true, desc = "Jump to previous placeholder" })

--     config = function()
--       local cmp = require("cmp")
--       local cmp_select = { behavior = cmp.SelectBehavior.Select }
--       local luasnip = require("luasnip")
--       require("luasnip.loaders.from_vscode").lazy_load()
--       luasnip.config.setup({})
--       -- '/' cmdline setup
--       cmp.setup.cmdline("/", {
--         mapping = cmp.mapping.preset.cmdline(),
--         sources = {
--           { name = "buffer" },
--         },
--       })
--       -- TODO: + shell suggestions?
--       -- cmp.setup.cmdline(":", {
--       -- 	mapping = cmp.mapping.preset.cmdline(),
--       -- 	sources = cmp.config.sources({
--       -- 		{ name = "path" },
--       -- 	}, {
--       -- 		{
--       -- 			name = "cmdline",
--       -- 			option = {
--       -- 				ignore_cmds = { "Man", "!" },
--       -- 			},
--       -- 		},
--       -- 	}),
--       -- })
--     end,
--   },
-- }
