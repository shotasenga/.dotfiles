# My .dotfiles

Installs applications and creates symlinks to the configs and scripts.

## Setup

```
git clone git@github.com:shotasenga/.dotfiles.git dotfiles
cd dotfiles
bash setup.sh
```

### Emacs

You need to manully run `all-the-icons-install-fonts` to render icons properly.

## Structure

| path       | description                            |
|------------|----------------------------------------|
| setup.sh   | The main setup script                  |
| macos.sh   | for macOS                              |
| arch.sh    | for Arch Linux                         |


## Machine specific local settings

### Git attributes

The `.gitconfig` file has `[include]` section with a value `path = ~/.gitconfig.local`. You can put your own attributes in it such as `user.name` and `user.email` thre.

```
[user]
    name = "Your Name"
    email = you@example.com
```

### Executables

Put your scripts/binaries in `$HOME/.local/bin`

