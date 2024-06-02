function fish_prompt
    # if test -n "$SSH_TTY"
    #     echo -n (set_color brred)"$USER"(set_color white)'@'(set_color yellow)(prompt_hostname)' '
    # end
    #
    # echo -n (set_color blue)(prompt_pwd)' '
    #
    # set_color -o
    # if fish_is_root_user
    #     echo -n (set_color red)'# '
    # end
    # echo -n (set_color red)'❯'(set_color yellow)'❯'(set_color green)'❯ '
    # set_color normal
    # if fish_is_root_user
    #     # string join '' -- (set_color red) '[root]' (set_color normal) '@'
    #     set_color red
    #     printf '[root]'
    # else
    #     set_color blue
    #     printf '[no root]'
    # end
    # set_color normal
    # printf ' in '
    # set_color blue
    # printf '%s' (prompt_pwd)
    # set_color green
    # set_color magenta
    if fish_is_root_user
        echo -n (set_color red)'[root] '
    end
    set_color normal
    echo $PWD '>'
    string join '' -- $PWD '>'
    echo (set_color red)foo
    string join '' -- (set_color green) $PWD (set_color normal) '>'
    string join '' -- (set_color green) (prompt_pwd) (set_color normal) '>'
    string join '' -- (set_color green) (prompt_pwd --full-length-dirs 2) (set_color normal) '>'
    echo (whoami)@(hostname) (date '+%Y-%m-%d %H:%M:%S') (pwd)
    echo "\$ "
    echo "╭─"
    echo "├─> "
    echo "╰─"
    echo -n (set_color white)'❯'(set_color yellow)'❯'(set_color green)'❯ '
end
