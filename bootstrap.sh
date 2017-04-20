#!/bin/bash

##########################################
# install all I need apps for Mac dev-env
# refers:
#   - https://github.com/lapwinglabs/blog/blob/master/hacker-guide-to-setting-up-your-mac.md
#   - http://veadardiary.blog29.fc2.com/blog-entry-6066.html
##########################################

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
brew update

# Tap Formula
brew tap homebrew/binary
brew tap homebrew/dupes
brew tap homebrew/php
brew tap homebrew/versions
brew tap caskroom/cask
brew tap caskroom/fonts
brew tap peco/peco
brew tap sanemat/font

##########################################
## Install binaries
##########################################
binaries=(
    # homebrew/php/php71-intl
    # homebrew/php/php71-mcrypt
    argon/mas/mas
    aspell
    awscli
    colordiff
    fasd
    ffmpeg
    git
    global
    go
    heroku
    homebrew/php/composer
    homebrew/php/php71
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
    zsh
)

echo "installing binaries..."
brew install ${binaries[@]}


##########################################
## Install Apps
##########################################
apps=(
    alfred
    appcleaner
    bettertouchtool
    charles
    coteditor
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
    vagrant
    virtualbox
)

# Install apps to /Applications
# Default is: /Users/$user/Applications
echo "installing apps..."
brew cask install --appdir="/Applications" ${apps[@]}

# add paths to Alfred
brew cask alfred link


##########################################
## Install Fonts
##########################################
fonts=(
    font-hack
)

echo "installing fonts..."
brew cask install ${fonts[@]}


##########################################
## Install Apps from Mac App Store
##########################################
# Note: to list all installed apps, just `mas list`
echo "installing Apps from App Store..."
mas install 529456740 # CheatSheet
mas install 419330170 # Moom
mas install 433335799 # CodeRunner
mas install 451640037 # Classic Color Meter
mas install 497799835 # Xcode
mas install 448925439 # Marked
mas install 432764806 # The Hit List
mas install 422304217 # Day One


echo "DONE! ALL APPLICATIONS INSTALLED |:3"


##########################################
## setup Node.js by nodebrew
##########################################
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
