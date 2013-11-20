#!/bin/sh

for name in *; do
  target="$HOME/.$name"
  if [ -e "$target" ] && [ ! -L "$target" ]; then
      echo "WARNING: $target exists but is not a symlink."
  else
    if [ "$name" != 'setup.sh' ] && [ "$name" != 'README.md' ]; then
      echo "Creating $target"
      rm "$target"
      ln -s "$PWD/$name" "$target"
    fi
  fi
done
