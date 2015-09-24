#!/bin/sh

for name in *; do
  target="$HOME/.$name"
  if [ -e "$target" ] && [ ! -L "$target" ]; then
      echo "WARNING: $target already exists however not a symlink"
  else
    if [ "$name" != 'setup.sh' ] && [ "$name" != 'README.md' ]; then
      echo "creating $target"
      rm "$target"
      ln -s "$PWD/$name" "$target"
    fi
  fi
done
