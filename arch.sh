#!/bin/bash

DOT_DIR=$(realpath $(dirname "${BASH_SOURCE[0]}"))

source $DOT_DIR/utils.sh

# pacman -Syy
# System
module yay

# X11
module x11

# Developer tools
# sudo pacman -S --needed tree htop jq
module git
module fish
module asdf
module tmux

# Editor
module emacs
module nvim

# Custom scripts
module scripts


# Install applications
pacman -S --needed bat plocate udisks2 opera
yay -S --needed anki-official-binary-bundle google-chrome zoom slack-desktop
