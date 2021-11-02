#!/bin/bash

DOT_DIR=$(realpath $(dirname "${BASH_SOURCE[0]}"))

main() {
    # pacman -Syy
    # sudo pacman -S --needed tree htop jq
}


module () {
    if [ -z $1 ]; then
        echo module name is required >&2
        return 1
    fi

    local MODULE_NAME=$1
    local MODULE_ROOT="${DOT_DIR}/${MODULE_NAME}"

    if [ ! -d $MODULE_ROOT ]; then
        echo "module '${MODULE_NAME}' is not available" >&2
        return 1
    fi

    echo installing $MODULE_NAME ...

    cd $MODULE_ROOT

    if [ -f "${MODULE_ROOT}/install.sh" ]; then
        bash "${MODULE_ROOT}/install.sh"
    fi

    local status=$?
    if [ $status -eq 0 -a -f "${MODULE_ROOT}/install-arch.sh" ]; then
        bash "${MODULE_ROOT}/install-arch.sh"
    fi
}


main
