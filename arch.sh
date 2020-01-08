#!/bin/bash

set -e

DOT_DIR=$( dirname "${BASH_SOURCE[0]}" )

if [ -z $HOME ]; then
    echo "\$HOME is not defined"
    exit 1
fi

# ------------------------------
# Pacman
# ------------------------------
pacman -Syy

# Shell
sudo pacman -S --needed fish
yay         -S --needed fisher
echo "you need to run `fisher` manually"

# CLI Applications
sudo pacman -S --needed aspell
sudo pacman -S --needed aws-cli
sudo pacman -S --needed ctags
sudo pacman -S --needed emacs
sudo pacman -S --needed fasd
sudo pacman -S --needed fd
sudo pacman -S --needed ffmpeg
sudo pacman -S --needed git
sudo pacman -S --needed httpie
sudo pacman -S --needed hugo
sudo pacman -S --needed imagemagick
sudo pacman -S --needed jq
sudo pacman -S --needed pandoc
sudo pacman -S --needed reflector
sudo pacman -S --needed ripgrep
sudo pacman -S --needed subversion
sudo pacman -S --needed tmux
sudo pacman -S --needed tree
sudo pacman -S --needed unarchiver
sudo pacman -S --needed unzip
sudo pacman -S --needed xsel
sudo pacman -S --needed youtube-dl
sudo pacman -S --needed z
sudo pacman -S --needed zip
sudo pacman -S --needed unarchiver
yay         -S --needed global
yay         -S --needed heroku-cli
yay         -S --needed peco
# brew install ccls
# brew install fasd


# GUI Aplications
sudo pacman -S --needed anki
yay         -S --needed charles
yay         -S --needed dropbox
yay         -S --needed google-chrome
sudo pacman -S --needed firefox
sudo pacman -S --needed processing
sudo pacman -S --needed zeal
sudo pacman -S --needed mysql-workbench
sudo pacman -S --needed dbeaver
yay         -S --needed toggldesktop
yay         -S --needed slack-desktop
sudo pacman -S --needed vagrant
sudo pacman -S --needed virtualbox
# brew cask install linear TODO: need to find an alternation https://github.com/mikaa123/linear

# Fonts
sudo pacman -S --needed adobe-source-han-sans-jp-fonts
sudo pacman -S --needed noto-fonts-emoji
sudo pacman -S --needed otf-fira-code

# ------------------------------
# Python
# ------------------------------
PATH=$HOME/.pyenv/shims:$PATH

sudo paman -S --needed pyenv python-pipenv
PYVERSION=$(pyenv install -l|grep -v -|tail -1|awk '{$1=$1};1')

if [ ! $(pyenv versions --bare|grep $PYVERSION) ]; then
    pyenv install $PYVERSION
    pyenv global $PYVERSION
    pyenv rehash
    pip install --upgrade pip
fi

# install LSP server for Python
# pip install python-language-server 'python-language-server[all]'


# ------------------------------
# Node.js
# ------------------------------
PATH=$HOME/.nvenv/current/bin:$PATH

yay -S --needed nvm
pacman -S --needed yarn
source /usr/share/nvm/init-nvm.sh

if [ ! $(node --version) ]; then
    nvm install --lts
    nvm use v12
    node --version
fi


# ------------------------------
# setup PHP
# ------------------------------
# TODO: phpbrew
sudo pacman -S --needed php composer
# if [ ! $(which phpbrew) ]; then
#     sudo curl -fsSL https://github.com/phpbrew/phpbrew/releases/latest/download/phpbrew.phar -o /usr/local/bin/phpbrew
#     chmod +x /usr/local/bin/phpbrew
#     phpbrew init
#     phpbrew lookup-prefix homebrew
# fi

# composer config -g repos.packagist composer https://packagist.jp
# composer global require hirak/prestissimo

# install LSP server for PHP
# composer global require felixfbecker/language-server
# composer global run-script --working-dir=$HOME/.composer/vendor/felixfbecker/language-server parse-stubs


# ------------------------------
# Ruby
# ------------------------------
yay -S --needed rbenv ruby-build

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

    # Rust is installed now. Great!
    # To get started you need Cargo's bin directory ($HOME/.cargo/bin) in your PATH
    # environment variable. Next time you log in this will be done
    # automatically.
    # To configure your current shell run source $HOME/.cargo/env
fi


# ------------------------------
# Make symlinks
# ------------------------------
bash $DOT_DIR/link.sh common
