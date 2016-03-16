#!/usr/bin/env zsh

# make symlinks
for name in *; do
    target="$HOME/.$name"
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        echo "WARNING: $target already exists however not a symlink"
    else
        if [ "$name" != 'setup.sh' ] && [ "$name" != 'README.md' ] && [ "$name" != 'bootstrap.sh' ]; then
            if [ -e "$target" ]; then
                rm "$target"
            fi
            echo ln -s "$PWD/$name" "$target"
            ln -s "$PWD/$name" "$target"
        fi
    fi
done

# setup prezto
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    target="${ZDOTDIR:-$HOME}/.${rcfile:t}"
    if [ -e "$target" ] && [ ! -L "$target" ]; then
        echo "WARNING: $target already exists however not a symtarget"
    elif [ -L "$target" ]; then
        echo "WARNING: $target already linked, skip it"
    else
        echo ln -s "$rcfile" "${target}"
        ln -s "$rcfile" "${target}"
    fi
done
