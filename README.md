# My .dotfiles

Install applications, binaries and then put DOTFILEs.

## Setup

1. clone this repository to ~/.dotfiles
2. run `bootstrap.sh` to install application and binaries (optional)
3. run `setup.sh` to put dotfiles

```
$cd
$git clone --recursive https://github.com/senta/.dotfiles.git .dotfiles
$sh bootstrap.sh
```

### Configure Git user

To configure `user.name` and `user.email` attribute on your machine, you can make `~/.gitconfig.local` like below. It include by `~/.gitconfig`.

```
[user]
    name = "Your Name"
    email = you@example.com
```
