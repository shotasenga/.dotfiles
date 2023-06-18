# My .dotfiles

Installs applications and creates symlinks to the configs and scripts.


## Setup

```
curl https://raw.githubusercontent.com/senta/.dotfiles/master/setup.sh| bash
```

### Emacs

You need to manully run `all-the-icons-install-fonts` to render icons.


## Script Structure

| path       | description                                        |
|------------|----------------------------------------------------|
| setup.sh   | The main setup script                              |
| marcos.sh  | Bash script for macOS                              |
| arch.sh    | Bash script for Arch Linux                         |


## Local Settings

You can have machine specific configs for some applications.

### Git attributes

`.gitconfig` have `[include]` section with a value `path = ~/.gitconfig.local`. You can put your own attributes in it such as `user.name` and `user.email` like below.

```
[user]
    name = "Your Name"
    email = you@example.com
```

### Executables

Put your scripts/binaries in `$HOME/.bin/local`

