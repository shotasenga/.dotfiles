if ! type -q fasd
    echo "`fasd` is not installed"
end

function _fasd_preexec -e fish_preexec
    # thanks: https://github.com/oh-my-fish/plugin-fasd/blob/master/conf.d/fasd.fish
    command fasd --proc (command fasd --sanitize "$argv" | tr -s ' ' \n) > "/dev/null" 2>&1 &; disown
end

function e -d "open a file in $EDITOR using fasd"
    fasd -Rfl | fzf -q "$argv" -1 -0 --no-sort +m | xargs $EDITOR
end

function j -d "jump to a directory"
    set -l path (fasd -Rdl | fzf -q "$argv" -1 -0 --no-sort +m )
    cd $path
end
