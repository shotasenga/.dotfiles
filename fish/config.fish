# ------------------------------
# fish configuration
# ------------------------------

## Paths
# - homebrew
set -x PATH /usr/local/bin /usr/local/sbin $PATH

# - nodebrew
set -x PATH $HOME/.nodebrew/current/bin $PATH

# - heroku
set -x PATH /usr/local/heroku/bin $PATH

# - cabel (Haskel)
set -x PATH $HOME/Library/Haskell/bin $PATH

# - composer
set -x PATH $HOME/.composer/vendor/bin $PATH

# - Android SDK
set -x ANDROID_HOME /Developer/SDKs/android-sdk-macosx
set -x PATH $PATH $ANDROID_HOME/tools $ANDROID_HOME/platform-tools

## rbenv
#eval (rbenv init -)


## Aliases
alias mkdir "mkdir -p"

alias sourcetree='open -a sourcetree'
alias cliptmux="tmux showb|pbcopy"
alias npm-exec='PATH=$(npm bin):$PATH'
alias del=rmtrash
alias https='http --default-scheme=https'

