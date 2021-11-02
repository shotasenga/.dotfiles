#!/bin/bash

MODULE_ROOT=$(realpath $(dirname "${BASH_SOURCE[0]}"))

FISH_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/fish"

if [ -e $FISH_CONFIG -a ! -L $FISH_CONFIG ]; then
    echo fish config already exists: $FISH_CONFIG
    exit 1
fi

ln -Tfs $MODULE_ROOT/fish $FISH_CONFIG

if [[ "$SHELL" != *fish ]]; then
    echo run the command below to change your shell to fish
    echo -e "\tchsh -s /usr/bin/fish"
fi
