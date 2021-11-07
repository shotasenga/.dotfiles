#!/bin/bash

set -e

MODULE_ROOT=$(realpath $(dirname "${BASH_SOURCE[0]}"))

source $MODULE_ROOT/../utils.sh

link_config $MODULE_ROOT/asdf/envrc "${HOME}/.envrc"
link_config $MODULE_ROOT/asdf/tool-versions "${HOME}/.tool-versions"
mkdir -p "${XDG_CONFIG_HOME:-$HOME/.config}/asdf"
link_config $MODULE_ROOT/default-python-packages "${XDG_CONFIG_HOME:-$HOME/.config}/default-python-packages"b

link_config $MODULE_ROOT/direnv "${XDG_CONFIG_HOME:-$HOME/.config}/direnv"

# TODO: move the script to this module directory from fish/functions
echo 'run "asdf_install_version" to install dependencies'


