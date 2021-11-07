#!/bin/bash

DOT_DIR=$(realpath $(dirname "${BASH_SOURCE[0]}"))

source $DOT_DIR/utils.sh

# pacman -Syy
# sudo pacman -S --needed tree htop jq
module fish
module git
module i3wm
module asdf
module emacs
module tmux
module nvim
module scripts
