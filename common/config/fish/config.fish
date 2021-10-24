if status is-login
    if [ -z "$DISPLAY" -a "$XDG_VTNR" = 1 ]
        exec startx -- -keeptty
    end
end
