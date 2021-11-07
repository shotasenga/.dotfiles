set -x LANG en_US.UTF-8

set -x XDG_CONFIG_HOME $HOME/.config

set -x EDITOR nvim
set -x VISUAL $EDITOR

switch (uname)
    case Linux
        # echo linux
    case Darwin
        set -x PATH /usr/local/bin /usr/local/sbin $PATH
        set -x PATH /Applications/Emacs.app/Contents/MacOS/bin $PATH
        set -x PATH "/Applications/Visual Studio Code.app/Contents/Resources/app/bin" $PATH
end

set -x PATH $HOME/.bin $PATH
set -x PATH $HOME/.local/bin $PATH
