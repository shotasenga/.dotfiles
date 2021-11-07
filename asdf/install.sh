#!/bin/bash

set -e

MODULE_ROOT=$(realpath $(dirname "${BASH_SOURCE[0]}"))

source $MODULE_ROOT/../utils.sh

link_config $MODULE_ROOT/asdf/envrc "${HOME}/.envrc"
link_config $MODULE_ROOT/asdf/tool-versions "${HOME}/.tool-versions"

if [[ "$SHELL" != *fish ]]; then
    # TODO: move the script to this module directory from fish/functions
    echo 'run "asdf_install_version" to install dependencies'
fi
