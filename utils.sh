#!/bin/bash

SYSTEM_NAME=""
case $(uname -s) in
    Linux)
        SYSTEM_NAME=arch
        ;;
    Darwin)
        SYSTEM_NAME=osx
        ;;
    *)
        echo Unknown system
        exit 1
        ;;
esac


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
    if [ $status -eq 0 -a -f "${MODULE_ROOT}/install-${SYSTEM_NAME}.sh" ]; then
        bash "${MODULE_ROOT}/install-${SYSTEM_NAME}.sh"
    fi
}


link_config() {
    SOURCE=$1
    DEST=$2

    if [ -e $DEST -a ! -L $DEST ]; then
        echo config already exists: $DEST
        return 1
    fi

    ln -Tfs $SOURCE $DEST
}
