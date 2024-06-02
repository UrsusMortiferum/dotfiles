#!/bin/bash

[ -z "$TMUX" ] && echo "Not in TMUX" && exit 1

tmpfile=$(mktemp /tmp/tmux-buffer-XXXXXX) || { echo "Failed to create temp file"; exit 1; }
tmux capture-pane -S -50000 -p > "$tmpfile" || { echo "Failed to capture pane"; exit 1; }
tmux send-keys "$EDITOR $tmpfile" C-m || { echo "Failed to send keys"; rm -f "$tmpfile"; exit 1; }

# If you want to remove the file after editing
# Put this autocmd in your nvim config
# vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
#   pattern = { "tmux-buffer-*" },
#   callback = function()
#     vim.cmd("! rm %")
#   end,
# })
