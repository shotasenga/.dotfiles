# -*- mode: shell-script -*-

# LANG
export LANG=en_US.UTF-8

# alias commands
alias diff="colordiff"
alias cotedit="open -a coteditor"
alias marked="open -a marked"
alias sourcetree='open -a sourcetree'
alias e='emacsclient'
alias preview='qlmanage -p '
alias cliptmux="tmux showb|pbcopy"
alias fuck=thefuck

# Editor
export EDITOR='emacsclient'
export SVN_EDITOR=$EDITOR

## rbenv
eval "$(rbenv init -)"

## phpenv
export PATH=$PATH:$HOME/.phpenv/bin
eval "$(phpenv init -)"

## Homebrew
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

## for Android SDK
ANDROID_SDK_PATH=/Developer/SDKs/android-sdk-macosx
export PATH=$PATH:$ANDROID_SDK_PATH/tools:$ANDROID_SDK_PATH/platform-tools
export ANDROID_HOME=$ANDROID_SDK_PATH

## Heroku
export PATH="/usr/local/heroku/bin:$PATH"

## nodebrew
alias nb=nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH

## cabel (Haskel)
export PATH="$HOME/Library/Haskell/bin:$PATH"

## composer
export PATH="$HOME/.composer/vendor/bin:$PATH"




## tmuxinator complition
# source $(rbenv prefix)/lib/ruby/gems/2.2.0/gems/tmuxinator-0.6.11/completion/tmuxinator.zsh

# tmux自動起動 (default session) ....__ http://d.hatena.ne.jp/flada_auxv/20121110/1352527081
# if [ -z "$TMUX" -a -z "$STY" ]; then
#     if type tmux >/dev/null 2>&1; then
#         if tmux has-session && tmux list-sessions | /usr/bin/grep 'default'; then
#             #tmux attach && echo "tmux attached session "
#             echo "mux default session is running."
#         else
#             tmuxinator start default && echo "tmuxinator started defailt session"
#         fi
#     fi
# fi
