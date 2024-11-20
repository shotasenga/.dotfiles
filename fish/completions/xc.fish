
function __complete_xc
    set -lx COMP_LINE (commandline -cp)
    test -z (commandline -ct)
    and set COMP_LINE "$COMP_LINE "
    /opt/homebrew/bin/xc
end
complete -f -c xc -a "(__complete_xc)"

