local M = {}

---Load mappings
---@param opts? table<string, any>
M.load = function(opts)
  -- Define key mappings
  vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
  vim.keymap.set("n", "<leader>bb", "<cmd>Telescope buffers<cr>", { desc = "Find buffers" })

  -- Override mappings with user-provided values (if any)
  if opts and opts.mappings then
    for mode, mappings in pairs(opts.mappings) do
      for key, command in pairs(mappings) do
        vim.keymap.set(mode, key, command)
      end
    end
  end
end

return M
