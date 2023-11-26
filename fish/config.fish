if status is-login
    if [ -z "$DISPLAY" -a "$XDG_VTNR" = 1 ]
        exec startx -- -keeptty
    end
    source ~/.config/fish/conf.d/50-fasd.fish # need this to overide `j` function coming from autojump.fish
end
