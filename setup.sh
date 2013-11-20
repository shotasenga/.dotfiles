#!/usr/bin/env bash

DOT_DIR=~/.dotfiles
DOT_FILES=$(ls -a $DOT_DIR|grep '^\.'|grep -vE '^(.git|.|..)$')

for file in $DOT_FILES
do
    if [ "$1" == "-f" ]
	then
        rm ~/$file
    fi
    ln -s $DOT_DIR/$file ~/$file
done
