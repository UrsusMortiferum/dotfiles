set -gx COLORTERM truecolor
set -gx EDITOR nvim

if test -d .git
    set -gx FZF_DEFAULT_COMMAND "fd --type f --hidden --exclude .git"
else
    set -gx FZF_DEFAULT_COMMAND "fd --type f --hidden"
end
# set -gx FZF_DEFAULT_OPTS "--height 40% --layout=reverse --border\
#     --preview 'bat --style=numbers --color=always --line-range :500 {}'"
# --bind 'ctrl-c:execute-silent(echo {} | pbcopy)'

function fs -d "Switch tmux session"
    tmux list-sessions -F "#{session_name}" | fzf | read -l result; and tmux switch-client -t "$result"
end

starship init fish | source
# Set up fzf key bindings
fzf --fish | source

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

set -U fish_greeting
