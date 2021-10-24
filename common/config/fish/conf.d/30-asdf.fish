if ! type -q asdf
    echo "`asdf` is not installed"
end

if [ -d /opt/asdf-vm/bin ]
    set PATH /opt/asdf-vm/bin $PATH
end

if [ -d $HOME/.asdf/bin ]
    set PATH $HOME/.asdf/bin $PATH
end

if asdf which direnv > /dev/null 2>&1
    # eval "$(env ASDF_DIRENV_VERSION=2.20.0 asdf direnv hook bash)"

    # A shortcut for asdf managed direnv.
    # direnv() { env ASDF_DIRENV_VERSION=2.20.0 asdf direnv "$@"; }
    asdf exec direnv hook fish | source
else
    echo "`direnv` is not installed"
end

set -x ASDF_PYTHON_DEFAULT_PACKAGES_FILE $XDG_CONFIG_HOME/asdf/default-python-packages

alias direnv="asdf exec direnv"


function asdf_install_versions -d "install all plugins I use for asdf"
    # direnv
    if ! asdf which direnv > /dev/null 2>&1
        asdf plugin-add direnv
        and asdf install direnv 2.28.0 # latest as of October 2021
        and asdf global direnv 2.28.0
    end

    # nodejs
    # you can skip pgg key check with NODEJS_CHECK_SIGNAURES=no
    if ! asdf which nodejs > /dev/null 2>&1
        asdf plugin add nodejs
        and asdf install nodejs lts-fermium
        and asdf global nodejs lts-fermium
    end

    # python
    if ! asdf which python > /dev/null 2>&1
        asdf plugin add python
        and asdf install python 3.9.7
        and asdf global python 3.9.7
    end

    # php
    # if ! asdf which php > /dev/null 2>&1
    #     asdf plugin-add php
    #     asdf install php 7.3.31
    #     asdf global php 7.3.31
    # end

    # TODO: ruby
    # TODO: go
    # TODO: rust
    # TODO: deno
end
