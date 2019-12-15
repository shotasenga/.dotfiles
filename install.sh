#!/bin/bash

set -e

REPO_URI=git@github.com:senta/.dotfiles.git
DESTINATION="$HOME/.dotfiles"

ENV_NAME="Unknown"
case $(uname -s) in
    # Linux*)
    #     ENV_NAME="linux";;
    Darwin*)
        ENV_NAME="macos";;
esac

if [ $ENV_NAME = "Unknown" ]; then
    echo "Unknown environment detected."
    exit 1
fi
   

if [ -e $DESTINATION ]; then
    echo "It seems like you already have the dotfiles"
    read -p "Do you want to run the setup script? [y/n]: " YN

    case $YN in
        [Yy]*) ;;
        *) exit 0;;
    esac
else
    echo git clone --recursive $REPO_URI $DESTINATION    
fi

sh $DESTINATION/$ENV_NAME.sh
