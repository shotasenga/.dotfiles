#!/bin/bash

set -e

MODULE_ROOT=$(realpath $(dirname "${BASH_SOURCE[0]}"))

source $MODULE_ROOT/../utils.sh

link_config $MODULE_ROOT/fish "${XDG_CONFIG_HOME:-$HOME/.config}/fish"
link_config $(realpath $MODULE_ROOT/../rtx) "${XDG_CONFIG_HOME:-$HOME/.config}/rtx"

if [[ "$SHELL" != *fish ]]; then
    echo run the command below to change your shell to fish
    echo -e "\tchsh -s /usr/bin/fish"
fi
