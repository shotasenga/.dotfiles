function fish_prompt
    # set monkey randomly
    set __r (random)
    if [ (math $__r '%7') -eq 1 ]
        printf '🐵'
    else if [ (math $__r '%3') -eq 1 ]
        printf '🙈'
    else if [ (math $__r '%2') -eq 1 ]
        printf '🙊'
    else
        printf '🙉'
    end

    # hostname
    # set_color 81a1c1
    # printf ' [%s]' (prompt_hostname)

    # show cwd
    set_color 81a1c1
    printf ' %s' (prompt_pwd)

    # show git infomation
    set_color normal
    printf '%s ' (__fish_git_prompt)

    # show FISH
    set_color -o ebcb8b
    printf '⋊> '
    set_color normal
end
