# .dotfiles

My dot files.

## Usage

cloning this repository to ~/.dotfiles (or whatever you want)

```
$ cd $HOME
$ git clone https://github.com/senta/.dotfiles.git
```

then create symlinks

```
$ cd .dotfiles
$ ./setup.sh
```

### configure Git user

To configure user.name/user.email you can make `~/.gitconfig.local` like below.

```
[user]
    name = "Paul McCartney"
    email = paul@beatle.com
```
