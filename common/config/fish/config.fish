# ------------------------------
# fish configuration
# ------------------------------
set -x LANG en_US.UTF-8

## Editor
set -x EDITOR emacsclient
set -x VISUAL $EDITOR

## Paths
# - local scripts
set -x PATH $HOME/.bin $PATH
set -x PATH $HOME/.bin/local $PATH

# # - nodebrew
# set -x PATH $HOME/.nodebrew/current/bin $PATH

# - php
# source ~/.phpbrew/phpbrew.fish
# set -x PATH $HOME/.composer/vendor/bin $PATH

# - Android SDK
# set -x ANDROID_HOME /Developer/SDKs/android-sdk-macosx
# set -x PATH $PATH $ANDROID_HOME/tools $ANDROID_HOME/platform-tools

# rbenv
status --is-interactive; and source (rbenv init -|psub)

# Deno
set -x PATH $HOME/.deno/bin $PATH

# Python
set -x PYENV_ROOT $HOME/.pyenv
set -x PATH $PYENV_ROOT/bin $PATH
set -x PIPENV_VENV_IN_PROJECT true
status --is-interactive; and source (pyenv init -|psub)
# status --is-interactive; and source (pyenv virtualenv-init -|psub)

# Rust
set -x PATH $HOME/.cargo/bin $PATH


## Aliases
alias vim="reattach-to-user-namespace vim"
alias e="emacsclient -n"
alias j z
alias mkdir "mkdir -p"
alias https='http --default-scheme=https'
alias less='less -R'
alias youtube-dl="youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best'"
alias pstree="pstree -g 2"
alias vue="npx -p @vue/cli vue"
alias create-react-app="npx create-react-app"

switch (uname)
    case Linux
        set -x SHELL /usr/bin/fish
        alias del='gio trash'
        alias pbcopy='xsel -i -p; and xsel -o -p | xsel -i -b'
        alias pbpaste='xsel -o'
    case Darwin
        set -x SHELL /usr/local/bin/fish
        set -x PATH /usr/local/bin /usr/local/sbin $PATH
        set -x PATH /Applications/Emacs.app/Contents/MacOS/bin $PATH
        set -x PATH "/Applications/Visual Studio Code.app/Contents/Resources/app/bin" $PATH

        alias del=rmtrash
        alias cliptmux="tmux showb|pbcopy"
        alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
        alias sourcetree='open -a sourcetree'
        alias vi="vim"
end


function gvm
    # https://github.com/moovweb/gvm/issues/137#issuecomment-131400212
    bass source ~/.gvm/scripts/gvm '; GOROOT_BOOTSTRAP=$GOROOT' gvm $argv
end

## Sync history between the settions
function sync_history --on-event fish_preexec
    history --save
    history --merge
end
