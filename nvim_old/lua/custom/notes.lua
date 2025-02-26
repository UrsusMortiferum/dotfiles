require("obsidian").setup({
  workspaces = {
    {
      name = "notes",
      path = "~/Notes/",
    },
  },
  notes_subdir = "0_in",
  new_notes_location = "notes_subdir",
  completion = { nvim_cmp = true, min_chars = 2 },
  templates = {
    folder = "~/Notes/Templates/",
    date_format = "%Y-%m-%d-%a",
    time_format = "%H:%M",
  },
  note_id_func = function(title)
    -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
    -- In this case a note with the title 'My new note' will be given an ID that looks
    -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
    local suffix = ""
    if title ~= nil then
      -- If title is given, transform it into valid file name.
      suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
    else
      -- If title is nil, just add 4 random uppercase letters to the suffix.
      for _ = 1, 4 do
        suffix = suffix .. string.char(math.random(65, 90))
      end
    end
    -- return tostring(os.time()) .. "-" .. suffix
    return os.date("%Y-%m-%d-%a-%H-%M-%S") .. "_" .. suffix
  end,
})
