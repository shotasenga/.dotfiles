# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# theme
ZSH_THEME="cloud"

# alias commands
alias diff="colordiff"
alias cotedit="open -a coteditor"
alias marked="open -a marked"
alias subl='open -a "sublime text 2"'
alias sourcetree='open -a sourcetree'
alias e='emacsclient'
alias bower='noglob bower'
alias preview='qlmanage -p '
alias cliptmux="tmux showb|pbcopy"

# oh-my-zsh settings
# export UPDATE_ZSH_DAYS=13
plugins=(git ruby osx bundler brew vagrant bower gem z)

source $ZSH/oh-my-zsh.sh

# Editor
export EDITOR='emacsclient'
export SVN_EDITOR=$EDITOR

# node path
export NODE_PATH="/usr/local/lib/node_modules"
export PATH="/usr/local/share/npm/bin:$PATH"

## rbenv setting
eval "$(rbenv init -)"
/usr/local/Cellar/rbenv/0.4.0/completions/rbenv.bash 

## phpenv
if [ -f $HOME/.phpenv/bin/phpenv ]; then
    export PATH=$PATH:$HOME/.phpenv/bin
    eval "$(phpenv init -)"
fi

## Homebrew
PATH=/usr/local/bin:/usr/local/sbin:$PATH
export PATH

## for Android SDK
ANDROID_SDK_PATH=/Developer/SDKs/android-sdk-macosx
export PATH=$PATH:$ANDROID_SDK_PATH/tools:$ANDROID_SDK_PATH/platform-tools


## ✪✪✪✪✪ 以下、整理する ✪✪✪✪✪✪

## tmuxinator complition
source ~/.rbenv/versions/2.0.0-p195/lib/ruby/gems/2.0.0/gems/tmuxinator-0.6.6/completion/tmuxinator.zsh

# tmux自動起動 (default session) ....__ http://d.hatena.ne.jp/flada_auxv/20121110/1352527081
if [ -z "$TMUX" -a -z "$STY" ]; then
    if type tmux >/dev/null 2>&1; then
        if tmux has-session && tmux list-sessions | /usr/bin/grep 'default'; then
            #tmux attach && echo "tmux attached session "
            echo "mux default session is running."
        else
            tmuxinator start default && echo "tmuxinator started defailt session"
        fi
    fi
fi

## wan to run sl
unalias sl