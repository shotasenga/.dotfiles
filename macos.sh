#!/bin/bash

set -e

DOT_DIR=$( dirname "${BASH_SOURCE[0]}" )

if [ -z $HOME ]; then
    echo "\$HOME is not defined"
    exit 1
fi

if [ ! $(xcode-select --install) ]; then
   echo "xcode-select is already installed."
fi


# ------------------------------
# Brew
# ------------------------------
PATH=/usr/local/bin:$PATH

if [ ! $(which brew) ]; then
    ruby -e "$(curl -fsS https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew update
brew upgrade

brew tap homebrew/cask
brew tap homebrew/cask-fonts
brew tap daviderestivo/emacs-head

# Dependencies
brew install jansson
brew install aspell
brew install ctags
brew install global
brew install mercurial
brew install openssl
brew install readline
brew install reattach-to-user-namespace
brew install xz
brew install zlib

# Shell
brew install fish
brew install fisherman

# Apps
brew install awscli
brew install ccls
brew install emacs-head --with-cocoa --with-imagemagick --with-jansson --HEAD
brew install fasd
brew install fd
brew install ffmpeg
brew install git
brew install heroku
brew install httpie
brew install hugo
brew install imagemagick
brew install jq
brew install pandoc
brew install peco
brew install pstree
brew install pup
brew install rename
brew install ripgrep
brew install rmtrash
brew install spark # https://github.com/holman/spark
brew install sqlite3
brew install subversion
brew install tig
brew install tmux
brew install tree
brew install watch
brew install youtube-dl


# ------------------------------
# Cask
# ------------------------------
# Apps
brew cask install alfred
brew cask install anki
brew cask install appcleaner
brew cask install bettertouchtool
brew cask install charles
brew cask install cyberduck
brew cask install dash
brew cask install dropbox
brew cask install firefox
brew cask install google-chrome
brew cask install hammerspoon
brew cask install hyperswitch
brew cask install karabiner-elements
brew cask install linear
brew cask install mysqlworkbench
brew cask install processing
brew cask install qlmarkdown
brew cask install qlprettypatch
brew cask install qlstephen
brew cask install quicklook-csv
brew cask install quicklook-json
brew cask install sequel-pro
brew cask install sketch
brew cask install slack
brew cask install toggl
brew cask install vagrant
brew cask install virtualbox
brew cask install visual-studio-code

# Fonts
brew cask install font-hack
brew cask install font-symbola
brew cask install font-fira-code


# ------------------------------
# Mac App Store
# ------------------------------
brew install mas

mas install 419330170  # Moom
mas install 1470584107 # Dato
mas install 425955336  # Skitch
mas install 425424353  # The
mas install 497799835  # Xcode
mas install 909566003  # iHex
mas install 1024640650 # CotEditor
mas install 1055511498 # Day One
mas install 1160374471 # PiPifier
mas install 529456740  # CheatSheet
mas install 904280696  # Things 3


# ------------------------------
# Python
# ------------------------------
# Package management:
#   install packages globally for day-to-day scripting and use pipenv for projects
#   that I want to maintain for a long/short term or something I want to share.
PATH=$HOME/.pyenv/shims:$PATH

brew install pipenv
brew install pyenv
brew install pyenv-virtualenv

PYVERSION=$(pyenv install -l|grep -v -|tail -1|awk '{$1=$1};1')

if [ ! $(pyenv versions --bare|grep $PYVERSION) ]; then
    pyenv install $PYVERSION
    pyenv global $PYVERSION
    pyenv rehash
    pip install --upgrade pip
fi

# install LSP server for Python
# pip install python-language-server 'python-language-server[all]'
# TODO: install termgraph https://github.com/mkaz/termgraph
# ex. git shortlog -s| awk '{print $2 " " $1}'| termgraph
# pip install termgraph


# ------------------------------
# Node.js
# ------------------------------
# TODO: switch back to nvm
PATH=$HOME/.nodebrew/current/bin:$PATH

brew install nodebrew

if [ ! $(nodebrew ls|grep 12) ]; then
    nodebrew install-binary 12
    nodebrew use 12
    npm install -g create-react-app
fi

brew install yarn


# ------------------------------
# setup PHP
# ------------------------------
# TODO: phpbrew
if [ ! $(which phpbrew) ]; then
    curl -fsSL https://github.com/phpbrew/phpbrew/releases/latest/download/phpbrew.phar -o /usr/local/bin/phpbrew
    chmod +x /usr/local/bin/phpbrew
    phpbrew init
    phpbrew lookup-prefix homebrew
fi

# composer config -g repos.packagist composer https://packagist.jp
# composer global require hirak/prestissimo

# install LSP server for PHP
# composer global require felixfbecker/language-server
# composer global run-script --working-dir=$HOME/.composer/vendor/felixfbecker/language-server parse-stubs


# ------------------------------
# Ruby
# ------------------------------
brew install "rbenv"

RUBYVERSION=$(rbenv install -l | grep -v - | tail -1| awk '{$1=$1};1')

if [ ! $(rbenv versions --bare|grep $RUBYVERSION) ]; then
    rbenv install $RUBYVERSION
    rbenv global $RUBYVERSION
    rbenv rehash
fi


# ------------------------------
# Go
# ------------------------------
# TODO: go installation files
# if [ ! $(which gvm) ]; then
#     curl -fsS https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer| bash
# fi

# source $HOME/.gvm/scripts/gvm
# export GOROOT_BOOTSTRAP=$GOROOT

# gvm install 1


# ------------------------------
# Rust
# ------------------------------
if [ ! $(which cargo) ]; then
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

    # install the formatter and LSP server for Rust
    # rustup component add rustfmt rls rust-analysis rust-src
fi


# ------------------------------
# Make symlinks
# ------------------------------
bash $DOT_DIR/link.sh common macos
