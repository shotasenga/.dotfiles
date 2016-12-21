# -*- mode: shell-script -*-
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
    source "${ZDOTDIR:-$HOME}/.zprezto/runcoms/zshrc"
fi


# Editor
export EDITOR='emacsclient'
export VISUAL=$EDITOR


# Export Paths
## local script
export PATH=$HOME/.bin:$PATH
export PATH=$HOME/.bin/local:$PATH

## Homebrew
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

## rbenv
eval "$(rbenv init -)"

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
alias npm-exec='PATH=$(npm bin):$PATH'
alias del=rmtrash
alias https='http --default-scheme=https'
alias less='less -R'

# Python3 as python
alias python2=/usr/bin/python2.7
alias pip2=/usr/local/bin/pip
alias python=/usr/local/bin/python3
alias pip=/usr/local/bin/pip3

# Functions (TODO: move functions to somewhere else)
## make a project direcoty
mkp () {
    if (( $# == 0 )); then
        echo "useage: mkp \$PROJECT_NAME"
        return
    fi
    PROJECT_NAME=$1
    echo "make project on ~/Dev/$PROJECT_NAME/"
    mkdir -p ~/Dev/$PROJECT_NAME/{apps,scripts,docs} && touch $(dirname $_)/note.org && e -n ~/Dev/$PROJECT_NAME/note.org
}
