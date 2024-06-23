require("obsidian").setup({
  workspaces = {
    { name = "notes", path = "~/notes/" },
  },
  completion = { nvim_cmp = true, min_chars = 2 },
  new_notes_location = "current_dir",
})
