vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.opt.shortmess:append("c")

local lspkind = require("lspkind")
lspkind.init({})

local cmp = require("cmp")

cmp.setup({
  sources = {
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "buffer" },
    { name = "codeium" },
    { name = "luasnip" },
    { name = "emoji" },
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
      require("luasnip").lsp_expand(args.body)
    end,
  },
})

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

vim.keymap.set({ "i", "s" }, "<c-k", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<c-j>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })

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
