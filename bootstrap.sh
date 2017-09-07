#!/bin/bash

# ------------------------------------------------------------
# Install binaries and apps for Mac dev-env
# refers:
#   - https://github.com/lapwinglabs/blog/blob/master/hacker-guide-to-setting-up-your-mac.md
#   - http://veadardiary.blog29.fc2.com/blog-entry-6066.html
# ------------------------------------------------------------


# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Tap Formula
brew tap homebrew/binary
brew tap homebrew/dupes
brew tap homebrew/php
brew tap homebrew/versions
brew tap caskroom/cask
brew tap caskroom/fonts
brew tap sanemat/font
brew tap fisherman/tap

# Update homebrew recipes
brew update

# ------------------------------
# Install binaries
# ------------------------------
binaries=(
    # homebrew/php/php71-intl
    # homebrew/php/php71-mcrypt
    argon/mas/mas
    aspell
    awscli
    colordiff
    fasd
    ffmpeg
    fisherman
    git
    global
    go
    heroku
    homebrew/php/php71
    homebrew/php/composer
    httpie
    hugo
    imagemagick
    jq
    nodebrew
    pandoc
    peco
    pngquant
    pstree
    python3
    rbenv
    reattach-to-user-namespace
    rename
    ripgrep
    rmtrash
    subversion
    tree
    watch
    xargs
    zsh
    fish
    unar
)

echo "installing binaries..."
brew install ${binaries[@]}


# ------------------------------
# Install Apps
# ------------------------------
apps=(
    alfred
    appcleaner
    anki
    bettertouchtool
    charles
    cyberduck
    dash
    dropbox
    emacs
    firefox
    flash
    google-chrome
    hyperswitch
    imagealpha
    imageoptim
    linear
    mysqlworkbench
    processing
    qlmarkdown
    qlprettypatch
    qlstephen
    quicklook-csv
    quicklook-json
    sequel-pro
    sketch
    vagrant
    virtualbox
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "installing apps..."
brew cask install --appdir="/Applications" ${apps[@]}


# ------------------------------
# Install Fonts
# ------------------------------
fonts=(
    font-hack
    font-symbola
)

echo "installing fonts..."
brew cask install ${fonts[@]}


# ------------------------------
# Install Apps from Mac App Store
# ------------------------------
# Note: You can get all installed apps by `mas list`
echo "installing Apps from App Store..."
mas install 529456740 # CheatSheet
mas install 419330170 # Moom
mas install 433335799 # CodeRunner
mas install 451640037 # Classic Color Meter
mas install 497799835 # Xcode
mas install 448925439 # Marked
mas install 432764806 # The Hit List
mas install 422304217 # Day One
mas install 1024640650 # CotEditor


echo "DONE! ALL APPLICATIONS INSTALLED |:3"


# ------------------------------
# setup Node.js by nodebrew
# ------------------------------
# nodebrew=$(brew --prefix)/bin/nodebrew
nodebrew install-binary v0.12
nodebrew install-binary v6
nodebrew use v6

# and then install npm packages
npm install -g yarn

# pkg=(
#     yarn
#     cssbeautify-cli
#     js-beautify
#     psd-cli
# )
# yarn global add ${apps[@]}


# ------------------------------
# setup PHP
# ------------------------------
composer config -g repos.packagist composer https://packagist.jp
composer global require hirak/prestissimo

# ------------------------------------------------------------
# Make symlinks
# ------------------------------------------------------------
for name in *; do
    target="$HOME/.$name"
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        echo "WARNING: $target already exists however not a symlink"
    else
        if [ "$name" != 'setup.sh' ] && [ "$name" != 'README.md' ] && [ "$name" != 'bootstrap.sh' ]; then
            if [ -e "$target" ]; then
                rm "$target"
            fi
            echo ln -s "$PWD/$name" "$target"
            ln -s "$PWD/$name" "$target"
        fi
    fi
done
