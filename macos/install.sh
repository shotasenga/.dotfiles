#!/bin/bash

set -e

MODULE_ROOT=$(realpath $(dirname "${BASH_SOURCE[0]}"))

source $MODULE_ROOT/../utils.sh

link_config $MODULE_ROOT/hammerspoon "${HOME}/hammerspoon"
link_config $MODULE_ROOT/karabiner "${XDG_CONFIG_HOME:-$HOME/.config}/karabiner"
