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
    ack
    ant
    argon/mas/mas
    aspell
    awscli
    cloog
    colordiff
    emacs
    fasd
    ffmpeg
    fontforge
    ghq
    git
    git-flow
    global
    go
    heroku
    homebrew/dupes/zlib
    homebrew/php/composer
    homebrew/php/php-build
    homebrew/php/php55
    homebrew/php/php55-intl
    homebrew/php/php55-mcrypt
    httpie
    hugo
    imagemagick
    jq
    libgcrypt
    libmpc
    multimarkdown
    neon
    nodebrew
    ossp-uuid
    packer
    pandoc
    peco
    pngquant
    potrace
    pstree
    python3
    rbenv
    re2c
    reattach-to-user-namespace
    rename
    rmtrash
    sdl
    subversion
    tree
    tree
    watch
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
    charles
    coteditor
    dropbox
    emacs
    firefox
    flash
    google-chrome
    mysqlworkbench
    qlmarkdown
    qlstephen
    quicklook-json
    quicklook-csv
    qlprettypatch
    karabiner
    seil
    sequel-pro
    virtualbox
    vagrant
    hyperswitch
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
mas install 425955336 # Skitch
mas install 451640037 # Classic Color Meter
mas install 499148234 # DragonDrop
mas install 497799835 # Xcode
mas install 435003921 # Fantastical
mas install 448925439 # Marked
mas install 432764806 # The Hit List
mas install 816730952 # Ruler+
mas install 422304217 # Day One
mas install 449589707 # Dash


echo "DONE! ALL APPLICATIONS INSTALLED |:3"
