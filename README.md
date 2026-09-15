# Dotfiles

## Setup
- `stow -nv .` -> compatibility check
-- `mv ~/.config/nvim ~/.config/nvim.bak` -> when conflicts spotted
- `stow -R .` -> restow/recreate

`stow --target="$HOME/.config" --adopt btop emacs ghostty hypr nvim`