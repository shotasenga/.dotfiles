#!/bin/bash

set -e

MODULE_ROOT=$(realpath $(dirname "${BASH_SOURCE[0]}"))

source $MODULE_ROOT/../utils.sh

# Xog
# TODO: confirm what packages are needed. I _guess_ xorg is a bundle and it includes xorg-xinit.
echo sudo pacman -S --needed xorg xorg-xinit xf86-video-intel mesa
echo pacman -Ss x86-video
echo sudo pacman -S xdg-utils # https://wiki.archlinux.org/title/Xdg-utils

# TODO: does sudo work with functions?
echo sudo put_config $MODULE_ROOT/xorg/00-keyboard.conf /etc/X11/xorg.conf.d/00-keyboard.conf
echo sudo put_config_super $MODULE_ROOT/xorg/20-intel.conf /etc/X11/xorg.conf.d/20-intel.conf

link_config $MODULE_ROOT/xorg/xinit "${HOME}/.xinitrc"
link_config $MODULE_ROOT/xorg/xprofile "${HOME}/.xprofile"
link_config $MODULE_ROOT/xorg/Xresources "${HOME}/.Xresources"
# TODO: what is .Xauthority?

# GTK (Emacs like keybindings)
# https://wiki.archlinux.org/title/GTK#Emacs_key_bindings
link_config $MODULE_ROOT/gtk/gtkrc-2.0 "${HOME}/.gtkrc-2.0"
# TODO: =.config/cgtk-3.0/settings.ini= and =gsettings=

# GUI Terminal
sudo pacman -S --needed kitty xclip
link_config $MODULE_ROOT/kitty "${XDG_CONFIG_HOME:-$HOME/.config}/kitty"


# External monitor
sudo pacman -S --needed autorandr acpid

link_config $MODULE_ROOT/autorandr "${XDG_CONFIG_HOME:-$HOME/.config}/autorandr"

# autorandr does not support lid close https://github.com/phillipberndt/autorandr/issues/104
# acpid is a solution https://github.com/phillipberndt/autorandr/issues/104#issuecomment-467361778
# TODO: does sudo work with functions?
echo sudo put_config $MODULE_ROOT/acpid/autorandr.sh /etc/acpid/autorandr.sh # ensure the file is executable
echo sudo put_config $MODULE_ROOT/acpid/events/lid-switch /etc/acpi/events/lid-switch


# Window manager
sudo pacman -S --needed i3-wm xss-lock i3lock polkit
yay -S --needed xidlehook

# TODO: consider create separated modules
sudo pacman -S --needed rofi dunst maim
yay -S --needed xidlehook dragon-drag-and-drop

link_config $MODULE_ROOT/i3 "${XDG_CONFIG_HOME:-$HOME/.config}/i3"
link_config $MODULE_ROOT/dunst "${XDG_CONFIG_HOME:-$HOME/.config}/dunst"
