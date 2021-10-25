if [ -d /opt/asdf-vm/bin ]
    set PATH /opt/asdf-vm/bin $PATH
    set -x ASDF_DIR /opt/asdf-vm
end

if [ -d $HOME/.asdf/bin ]
    set PATH $HOME/.asdf/bin $PATH
end

set -x NODEJS_CHECK_SIGNATURES no # TODO: why it cannot verify the signature?
set -x ASDF_PYTHON_DEFAULT_PACKAGES_FILE $XDG_CONFIG_HOME/asdf/default-python-packages
set -x PHP_WITHOUT_PDO_PGSQL yes # This is so ugly. I also needed to install extra packages like libzip on Arch

if ! type -q asdf
    echo "`asdf` is not installed"
else
    alias direnv="asdf exec direnv"

    if asdf which direnv > /dev/null 2>&1
        asdf exec direnv hook fish | source
    else
        echo "`direnv` is not installed."
        echo "run `asdf_install_versions` to install missing packages."
    end
end
