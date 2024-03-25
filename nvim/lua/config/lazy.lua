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

require("config.utils").lazy_file()

require("lazy").setup({
  spec = "plugins",
  install = { missing = true, colorscheme = { "tokyonight-night" } },
  change_detection = { notify = false },
})

vim.keymap.set("n", "<leader>ll", "<cmd>:Lazy<CR>", { desc = "[L]aunch [L]azy" })
