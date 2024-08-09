type autojump 2>&1 > /dev/null # preload autojump.fish to prevent overriding `j`

function j -d "jump to a directory"
    set -l path (autojump -s dot 2>&1|grep -E '^[0-9\.]+:\s+/'|sort -nr|cut -d (echo -n \t) -f 2 | fzf -q "$argv" -1 -0 --no-sort +m )
    cd $path
end
