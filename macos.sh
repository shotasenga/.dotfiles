#!/bin/bash

set -ex

DOT_DIR=$(realpath $(dirname "${BASH_SOURCE[0]}"))

set HOMEBREW_NO_AUTO_UPDATE=1

if [ $(which brew) ]; then
    echo brew update
else
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew bundle --file $DOT_DIR/Brewfile

# WARN: this replaces the target files if exist
ln -Tfs $DOT_DIR/git/git "${XDG_CONFIG_HOME:-$HOME/.config}/git"
ln -Tfs $DOT_DIR/fish/fish "${XDG_CONFIG_HOME:-$HOME/.config}/fish"
ln -Tfs $DOT_DIR/rtx "${XDG_CONFIG_HOME:-$HOME/.config}/rtx"
ln -Tfs $DOT_DIR/emacs/emacs.d "${HOME}/.emacs.d"
ln -Tfs $DOT_DIR/nvim/nvim "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"
ln -Tfs $DOT_DIR/macos/hammerspoon "${HOME}/hammerspoon"
ln -Tfs $DOT_DIR/scripts/bin "${HOME}/.bin"
ln -Tfs $DOT_DIR/tmux/tmux/tmux.conf "${HOME}/.tmux.conf"
ln -Tfs $DOT_DIR/tmux/tmux/tmux.mac.conf "${HOME}/.tmux.env.conf"

# Post install
# - fish as default shell
FISH_BIN=$(brew --prefix)/bin/fish
if ! grep -q $FISH_BIN /etc/shells; then
    sudo bash -c "echo ${FISH_BIN} /etc/shells"
fi

if [[ "$SHELL" != *fish ]]; then
    chsh -s /usr/bin/fish
fi

# - tmux plugins
if [ ! -d "${HOME}/.tmux" ]; then
    mkdir -p "${HOME}/.tmux"
fi

if [ ! -e "${HOME}/.tmux/tmux-open" ]; then
    # https://github.com/tmux-plugins/tmux-open
    git clone git@github.com:tmux-plugins/tmux-open.git "${HOME}/.tmux/tmux-open"
fi

# - ssh key
if [ ! -d ~/.ssh ]; then
    mkdir ~/.ssh
fi

if [ ! -f ~/.ssh/id_ed25519 ]; then
    ssh-keygen -t ed25519 -C "${USER}@${HOSTNAME}"
    gh auth login
fi

echo COMPLETED 🎉
