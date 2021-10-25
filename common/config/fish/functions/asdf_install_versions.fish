function asdf_install_versions -d "install all missing versions for the system/a project"
    set -l versions_file

    if [ -f $PWD/.tool-versions ]
        set versions_file $PWD/.tool-versions
    else
        set versions_file $HOME/.tool-versions
    end

    echo installing versions based on: $versions_file

    set -l installed_packages
    set -l missing_packages
    set -l xxx

    cat $versions_file | while read -l line
        set -l item (echo $line | string split ' ')

        if asdf list $item[1] 2>&1 |grep -q $item[2]
            set -a installed_packages $line
        else
            set -a missing_packages $line
        end
    end

    echo "Installed:"
    if [ (count $installed_packages) -eq 0 ]
        echo "None"
    else
        echo $installed_packages
    end

    echo "Missing:"
    if [ (count $missing_packages) -eq 0 ]
        echo "None"
    else
        echo $missing_packages
    end

    __asdf_install_versions_confirm "do you want to install the missing packages?" || return 1

    for item in $missing_packages
        __asdf_install_versions_install $item
        and echo Successfully installed $item
        or echo Failed to instal $item
    end
end


function __asdf_install_versions_confirm
    set -l message $argv[1]

    read -P "$message [y/n]:" -l result

    if [ "$result" != "y" ]
        return 1
    end
end


function __asdf_install_versions_install
    set -l package (string split ' ' $argv[1])

    echo installing $package ...

    if asdf plugin list | ! grep -q $package[1]
        asdf plugin-add $package[1]
        or return 1
    end

    asdf install $package[1] $package[2]
end
