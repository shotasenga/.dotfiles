#!/bin/bash

set -e

MODULE_ROOT=$(realpath $(dirname "${BASH_SOURCE[0]}"))

source $MODULE_ROOT/../utils.sh

link_config $MODULE_ROOT/i3 "${XDG_CONFIG_HOME:-$HOME/.config}/i3"
link_config $MODULE_ROOT/dunst "${XDG_CONFIG_HOME:-$HOME/.config}/dunst"

sudo pacman -S --needed i3-wm rofi dunst
