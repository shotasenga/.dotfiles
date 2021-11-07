#!/bin/bash

set -e

MODULE_ROOT=$(realpath $(dirname "${BASH_SOURCE[0]}"))

source $MODULE_ROOT/../utils.sh

link_config $MODULE_ROOT/tmux/tmux.conf "${HOME}/.tmux.conf"

if [ ! -e "${HOME}/.tmux.env.conf" ]; then
    touch "${HOME}/.tmux.env.conf"
fi


# Installing plugins

mkdir -p "${HOME}/.tmux"

if [ ! -e "${HOME}/.tmux/tmux-open" ]; then
    # https://github.com/tmux-plugins/tmux-open
    git clone git@github.com:tmux-plugins/tmux-open.git "${HOME}/.tmux/tmux-open"
fi
