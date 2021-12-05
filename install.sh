#!/bin/bash
#
# Usage:
#   git clone git@github.com:shotasenga/.dotfiles.git
#   bash ./.dotfiles/install.sh

set -e

DOT_DIR=$(realpath $(dirname "${BASH_SOURCE[0]}"))

case $(uname -s) in
    Linux)
        bash $DOT_DIR/arch.sh
        ;;
    Darwin)
        bash $DOT_DIR/macos.sh
        ;;
    *)
        echo Unknown system
        exit 1
        ;;
esac
