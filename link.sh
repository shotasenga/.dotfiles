#!/bin/bash

set -e

DOT_DIR=$( dirname "${BASH_SOURCE[0]}" )

if [ -z $HOME ]; then
    echo "\$HOME is not defined"
    exit 1
fi

create_symlinks() {
    # Parameters
    #   $1 {string} source directory will be walked through
    local SOURCE_DIR="$DOT_DIR/$1"

    for FILE in $(ls "$SOURCE_DIR" 2>/dev/null); do
        local TARGET="$HOME/.$FILE"
        local SOURCE="$SOURCE_DIR/$FILE"

        echo create a link "'$TARGET" from "'$SOURCE'"

        if [ -e "$TARGET" ] && [ ! -L "$TARGET" ]; then
            echo "WARNING: $TEARGET already exists however not a symlink"
        else
            if [ -L "$TARGET" ]; then
                echo "WARNING: $TARGET is already linked and will be updated"
                rm "$TARGET"
            fi
            ln -s $SOURCE $TARGET
        fi
    done
}

for module in $@; do
    create_symlinks $module
done
