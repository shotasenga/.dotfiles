function fzf_history -d "Search command history using `fzf`"
    history | fzf -q (commandline) | read -l result
    and commandline -- $result
    commandline -f repaint
end
