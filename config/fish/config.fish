# ------------------------------
# fish configuration
# ------------------------------

## Editor
set -x EDITOR emacsclient
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


## Aliases
alias mkdir "mkdir -p"
alias sourcetree='open -a sourcetree'
alias cliptmux="tmux showb|pbcopy"
alias del=rmtrash
alias https='http --default-scheme=https'
alias less='less -R'

# Python3 as default python
alias python2=/usr/bin/python2.7
alias pip2=/usr/local/bin/pip
alias python=/usr/local/bin/python3
alias pip=/usr/local/bin/pip3
