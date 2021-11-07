#!/bin/bash

set -e

MODULE_ROOT=$(realpath $(dirname "${BASH_SOURCE[0]}"))

source $MODULE_ROOT/../utils.sh

link_config $MODULE_ROOT/tmux/tmux.arch.conf "${HOME}/.tmux.env.conf"

sudo pacman -S --needed tmux
