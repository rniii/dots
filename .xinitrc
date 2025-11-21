#!/bin/sh
if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# export QT_STYLE_OVERRIDE=kvantum

# export GTK_IM_MODULE=fcitx
# export QT_IM_MODULE=fcitx
# export XMODIFIERS=@im=fcitx

# xsetroot -cursor_name left_ptr &
# light -G &
# systembus-notify &
# picom &
# unclutter &
# dunst &
# lxsession &
# (sleep 2 && nitrogen --restore) &

[ -f ~/.xprofile ] && . ~/.xprofile

export DESKTOP_SESSION=plasma
export KDEWM=/usr/bin/bspwm

exec startplasma-x11
