local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = "ursusmortiferum.lazy",
  install = { missing = true, colorscheme = { "tokyonight-night" } },
  change_detection = { notify = false },
  -- ui = {
  -- 	icons = {
  -- 		cmd = "⌘",
  -- 		config = "🛠",
  -- 		event = "📅",
  -- 		ft = "📂",
  -- 		init = "⚙",
  -- 		keys = "🗝",
  -- 		plugin = "🔌",
  -- 		runtime = "💻",
  -- 		source = "📄",
  -- 		start = "🚀",
  -- 		task = "📌",
  -- 	},
  -- },
})

vim.keymap.set("n", "<leader>ll", "<cmd>:Lazy<CR>", { desc = "[L]aunch [L]azy" })
