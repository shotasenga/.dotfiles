#!/bin/bash

MODULE_ROOT=$(realpath $(dirname "${BASH_SOURCE[0]}"))

I3WM_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/i3"
DUNST_CONFIG="${XDG_CONFIG_HOME:-$HOME/.config}/dunst"

if [ -e $I3WM_CONFIG -a ! -L $I3WM_CONFIG ]; then
    echo i3 config already exists: $I3WM_CONFIG
    exit 1
fi

if [ -e $DUNST_CONFIG -a ! -L $DUNST_CONFIG ]; then
    echo dunst config already exists: $DUNST_CONFIG
    exit 1
fi

ln -Tfs $MODULE_ROOT/i3 $I3WM_CONFIG
ln -Tfs $MODULE_ROOT/dunst $DUNST_CONFIG

sudo pacman -S --needed i3-wm rofi dunst
