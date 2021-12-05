#!/bin/bash

if [ $(command -v yay) ]; then
   exit 0
fi

INSTALL_TARGET_DIR=/opt/yay

sudo pacman -S --needed --needed git base-devel
# TODO: make sure the <directory> option works as expected
sudo git clone https://aur.archlinux.org/yay.git $INSTALL_TARGET_DIR
sudo chown -R "${USER}:wheel" $INSTALL_TARGET_DIR
cd $INSTALL_TARGET_DIR
makepkg -si
