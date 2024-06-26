set -gx COLORTERM truecolor
set -gx EDITOR nvim

if test -d .git
    set -gx FZF_DEFAULT_COMMAND "fd --hidden --exclude .git"
else
    set -gx FZF_DEFAULT_COMMAND "fd --hidden"
end

function fs -d "Switch tmux session"
    tmux list-sessions -F "#{session_name}" | fzf | read -l result; and tmux switch-client -t "$result"
end

starship init fish | source
enable_transience

# Set up fzf key bindings
fzf --fish | source

pyenv init - | source
set -Ux PYENV_ROOT $HOME/.pyenv
fish_add_path $PYENV_ROOT/bin
set -x PYTHON_CONFIGURE_OPTS --enable-framework
# To avoid a clash between Pyenv and Brew
alias brew="env PATH=(string replace (pyenv root)/shims '' \"\$PATH\") brew"

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

# Created by `pipx` on 2024-06-06 11:09:35
set PATH $PATH /Users/ursusmortiferum/.local/bin
