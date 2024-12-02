function fzf_complete_git
    set -l subcmd $argv[2]

    switch $subcmd
        case add
            git status -s | fzf -m -q "$argv[3..]" | awk '{print $2}'
        case fixup
        case show
            git log --pretty=format:"%C(auto)%h %s author:%an" | fzf --no-sort -q "$argv[3..]" | awk '{print $1}'
        case '*'
            git branch --format '%(refname:lstrip=2)' | fzf +m -q "$argv[3..]"
    end
end
