set -gx COLORTERM truecolor
set -gx EDITOR nvim

fish_config theme choose "tokyonight_night"

starship init fish | source

set -U fish_greeting
