# ------------------------------
# fish configuration
# ------------------------------
set -x LANG C

## Editor
set -x EDITOR vim
set -x VISUAL $EDITOR


## Paths
# - local scripts
set -x PATH $HOME/.bin $PATH
set -x PATH $HOME/.bin/local $PATH

# - homebrew
set -x PATH /usr/local/bin /usr/local/sbin $PATH

# - nodebrew
set -x PATH $HOME/.nodebrew/current/bin $PATH

# - composer
# set -x PATH $HOME/.composer/vendor/bin $PATH

# - Android SDK
# set -x ANDROID_HOME /Developer/SDKs/android-sdk-macosx
# set -x PATH $PATH $ANDROID_HOME/tools $ANDROID_HOME/platform-tools

## rbenv
status --is-interactive; and source (rbenv init -|psub)


# Emacs
set -x PATH /Applications/Emacs.app/Contents/MacOS/bin $PATH

# VS Code
set -x PATH "/Applications/Visual Studio Code.app/Contents/Resources/app/bin" $PATH

# Deno
set -x PATH $HOME/.deno/bin $PATH

# Python
set -x PYENV_ROOT $HOME/.pyenv
set -x PATH $PYENV_ROOT/bin $PATH
status --is-interactive; and source (pyenv init -|psub)
set -x PIPENV_VENV_IN_PROJECT true
# status --is-interactive; and source (pyenv virtualenv-init -|psub)


## Aliases
alias vim="reattach-to-user-namespace vim"
alias vi="vim"
alias e $EDITOR
alias j z
alias mkdir "mkdir -p"
alias sourcetree='open -a sourcetree'
alias cliptmux="tmux showb|pbcopy"
alias del=rmtrash
alias https='http --default-scheme=https'
alias less='less -R'
alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
alias youtube-dl="youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best'"
alias pstree="pstree -g 2"
alias vue="npx -p @vue/cli vue"
alias create-react-app="npx create-react-app"
alias diff="colordiff"

## Sync history between the settions
function sync_history --on-event fish_preexec
    history --save
    history --merge
end