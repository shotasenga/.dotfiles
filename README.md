# My .dotfiles

Installs applications and creates links to configuration files.


## Setup

```
curl https://raw.githubusercontent.com/senta/.dotfiles/master/install.sh| sh
```

### Emacs

You need to manully run `all-the-icons-install-fonts` to render icons.

## Script Structure

| path       | description                                        |
|------------|----------------------------------------------------|
| install.sh | The main setup script                              |
| link.sh    | A submodule that creates symlinks for each configs |
| darwin.sh  | Mac specific setup script                          |
| arch.sh    | To be implemented ...                              |
| common/    | Conf files to be linked for all environments       |
| macos/     | Conf files to be linked for _MacOS_                |



## Local Settings

When you want to have machine specific setup, you can inject some extra configurations.


### Git attributes

`.gitconfig` have `[include]` section with a value `path = ~/.gitconfig.local`. You can put your own attributes in it such as `user.name` and `user.email` like below.

```
[user]
    name = "Your Name"
    email = you@example.com
```

### Executables

The `$PATH` for fish includes `$HOME/.bin/local`. Put your tool on there.

