set -gx COLORTERM truecolor
set -gx EDITOR nvim

fish_config theme choose tokyonight_night

if status --is-interactive
    if not set -q TMUX
        set -l sessions (tmux ls 2>/dev/null)

        if test (count $sessions) -eq 0
            tmux new-session
        else
            set -l last_session (echo $sessions | tail -n 1 | awk -F: '{print $1}')
            tmux attach-session -t $last_session
        end
    end
end

starship init fish | source

set -U fish_greeting
