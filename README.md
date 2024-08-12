# My .dotfiles

A set of applications and their config files + small util scripts.


## Instruction

Clone the repo and run `setup.sh`. That's it!

```
git clone git@github.com:shotasenga/.dotfiles.git dotfiles
cd dotfiles
bash setup.sh
xc emacs
```

## File structure

| path       | description                            |
|------------|----------------------------------------|
| setup.sh   | The main setup script                  |
| macos.sh   | for macOS                              |
| arch.sh    | for Arch Linux                         |


## Machine specific local settings

### Fish custom config

Create a fish script in the `fish/conf.d/` directory suffixing with `.local.fish`.

### Git attributes

The `.gitconfig` file has `[include]` section with a value `path = ~/.gitconfig.local`. You can put your own attributes in it such as `user.name` and `user.email` thre.

```
[user]
    name = "Your Name"
    email = you@example.com
```

### Executables

All scripts/binaries are in `$HOME/.local/bin`.


## Tasks

### Install

Install and/or update dependencies and create links to config files.

```sh
bash setup.sh
```

### Emacs

You need to manully run `all-the-icons-install-fonts` to render icons properly.

```sh
yes | emacs --batch --eval '(load "~/.emacs.d/init.el")' --eval '(all-the-icons-install-fonts)'
```
