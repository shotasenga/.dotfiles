# TODO: replace with rtx
function fzf_complete_asdf
    set -l subcmd $argv[2]

    switch $subcmd
        case install
            asdf list-all $argv[3] | fzf -m +s --tac -q "$argv[4..]"
        case uninstall
            asdf list $argv[3] | fzf -m +s --tac -q "$argv[4..]"
        case '*'
            return
    end
end
