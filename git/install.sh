#!/bin/bash

set -e

MODULE_ROOT=$(realpath $(dirname "${BASH_SOURCE[0]}"))

source $MODULE_ROOT/../utils.sh

link_config $MODULE_ROOT/git "${XDG_CONFIG_HOME:-$HOME/.config}/git"

if [ ! -f ~/.ssh/id_ed25519 ]; then
    echo You mway want to create ssh key and add it to Github
    echo -e "\tssh-keygen -t ed25519 -C '${USER}@${HOSTNAME}'"
    echo Or you can use github-cli
    echo -e "\tgh auth login"
fi
