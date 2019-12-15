# My .dotfiles

Installs applications and creates links to configuration files.


## Setup

```
curl https://raw.githubusercontent.com/senta/.dotfiles/master/setup.sh| sh
```


## Directory Structure

| directory | description                           |
|-----------+---------------------------------------|
| `common/` | conf files for both _MacOS and Linux_ |
| `macos/`  | conf files for _MacOS_                |


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

