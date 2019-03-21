#!/usr/bin/env bash

xrdb "$HOME/.Xresources"

xset b off

xset mouse 0 0

xset r rate 200 50

xset dpms force on
xset s default

setxkbmap -layout us,ru -option grp:alt_shift_toggle

urxvtd --quiet --opendisplay --fork

xsetroot -cursor_name left_ptr

xmodmap "$HOME/.Xmodmap"

hsetroot -fill "$HOME/pictures/wallpapers/mill.png"

unclutter --fork --ignore-scrolling

autocutsel -fork
autocutsel -fork -selection PRIMARY

eval "$(/usr/bin/gpg-agent --daemon)"

fcitx -r -d -s 0 &

compton -b --config "$HOME/.config/compton.conf"
