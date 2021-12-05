# i3wm

[i3wm](https://i3wm.org/) with [rofi](https://github.com/davatorium/rofi) as d-menu replacement and [Dunst](https://dunst-project.org/) for notification.

## Screen lock

Using `i3-lock`  with `xss-lock` and `xidlehook` (AUR) to lock th screen. Also using `polkit` to control privileged processes.

see: https://wiki.archlinux.org/title/i3#Shutdown,_reboot,_lock_screen

## Dunst

The base config is copied from `/etc/dunst/dunstrc`. See [Arch wiki](https://wiki.archlinux.org/title/Dunst) for the details.

## External display

Use [xrandr](https://wiki.archlinux.org/title/Xrandr) to manualy control display output, and [autorandr](https://github.com/phillipberndt/autorandr) for automate switching display settings based on the connection.

- `xrandr` to show available displays
- `xrandr --output DP1 --auto --above eDP1` to use DP1 above the primary (laptop) screen.
- `xrandr --auto` when disconnected will reset the screen.

## xclip vs xsel

Xclip handles binaries (images) better so I chose `xclip`.

```
echo 'hey' | xclip -selection clipboard
echo 'hey' | xclip -sel clip
```
