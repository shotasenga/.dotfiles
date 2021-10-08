#!/bin/zsh

# Zsh
# export ZDOTDIR=${XDG_CONFIG_HOME:-$HOME/.config}/zsh This is defined in the global .zsenv

# Editor
export EDITOR=vim
export VISUAL=$EDITOR

# PATH
typeset -U PATH path
path+=($HOME/.local/bin)
