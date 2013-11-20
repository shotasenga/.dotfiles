# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# theme
ZSH_THEME="cloud"

# alias commands
alias diff="colordiff"
alias cotedit="open -a coteditor"
alias marked="open -a marked"
alias subl='open -a "sublime text 2"'
alias intellij='open -a "IntelliJ IDEA 12"'
alias sourcetree='open -a sourcetree'
alias e='emacs'
alias pow='"/Users/senta/Library/Application Support/Pow/Current/bin/pow"'

# oh-my-zsh settings
# export UPDATE_ZSH_DAYS=13
plugins=(git ruby osx bundler brew vagrant bower gem z)

source $ZSH/oh-my-zsh.sh

# Editor
export EDITOR=emacs
export SVN_EDITOR=$EDITOR

# node path
export NODE_PATH="/usr/local/lib/node"
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
