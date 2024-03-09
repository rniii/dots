#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

export QT_STYLE_OVERRIDE=kvantum

export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

xsetroot -cursor_name left_ptr &
nitrogen --restore &
systembus-notify &
picom &
unclutter &
cantata &

[ -f ~/.xprofile ] && . ~/.xprofile

exec bspwm
