# -*- mode: shell-script -*-

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zshrc"
fi


# Editor
export EDITOR='emacsclient'
export VISUAL=$EDITOR


# Export Paths

## Homebrew
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

## rbenv
eval "$(rbenv init -)"

## phpenv
export PATH=$HOME/.phpenv/bin:$PATH
eval "$(phpenv init -)"

## nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH

## Heroku
export PATH="/usr/local/heroku/bin:$PATH"

## cabel (Haskel)
export PATH="$HOME/Library/Haskell/bin:$PATH"

## composer
export PATH="$HOME/.composer/vendor/bin:$PATH"

## Android SDK
ANDROID_SDK_PATH=/Developer/SDKs/android-sdk-macosx
export PATH=$PATH:$ANDROID_SDK_PATH/tools:$ANDROID_SDK_PATH/platform-tools
export ANDROID_HOME=$ANDROID_SDK_PATH


# Aliases
alias sourcetree='open -a sourcetree'
alias cliptmux="tmux showb|pbcopy"
alias nb=nodebrew
